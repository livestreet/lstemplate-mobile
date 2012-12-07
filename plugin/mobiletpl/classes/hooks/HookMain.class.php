<?php

class PluginMobiletpl_HookMain extends Hook {

	protected $bIsNeedShowMobile=null;

	public function RegisterHook() {
		$this->AddHook('viewer_init_start', 'ViewerInitStart');
		$this->AddHook('lang_init_start', 'LangInitStart');
		$this->AddHook('template_footer_menu_navigate_item', 'MenuItem');
		$this->AddHook('template_profile_whois_activity_item', 'WhoisActivityItem');
		$this->AddHook('init_action', 'InitAction');
		$this->AddHook('topic_show', 'TopicShow');

		if (!class_exists('MobileDetect')) {
			require_once(Plugin::GetPath(__CLASS__).'classes/lib/mobile-detect/MobileDetect.php');
		}
	}

	public function InitAction() {
		$oUserCurrent=$this->User_GetUserCurrent();
		if (!$oUserCurrent) {
			return;
		}
		if (!MobileDetect::IsNeedShowMobile()) {
			return;
		}
		/**
		 * Загружаем в шаблон необходимые переменные
		 */
		$iCountTopicFavourite=$this->Topic_GetCountTopicsFavouriteByUserId($oUserCurrent->getId());
		$iCountTopicUser=$this->Topic_GetCountTopicsPersonalByUser($oUserCurrent->getId(),1);
		$iCountCommentUser=$this->Comment_GetCountCommentsByUserId($oUserCurrent->getId(),'topic');
		$iCountCommentFavourite=$this->Comment_GetCountCommentsFavouriteByUserId($oUserCurrent->getId());
		$iCountNoteUser=$this->User_GetCountUserNotesByUserId($oUserCurrent->getId());

		$this->Viewer_Assign('iCountWallUserCurrent',$this->Wall_GetCountWall(array('wall_user_id'=>$oUserCurrent->getId(),'pid'=>null)));
		/**
		 * Общее число публикация и избранного
		 */
		$this->Viewer_Assign('iCountCreatedUserCurrent',$iCountNoteUser+$iCountTopicUser+$iCountCommentUser);
		$this->Viewer_Assign('iCountFavouriteUserCurrent',$iCountCommentFavourite+$iCountTopicFavourite);
		$this->Viewer_Assign('iCountFriendsUserCurrent',$this->User_GetCountUsersFriend($oUserCurrent->getId()));
	}
	/**
	 * Инициализация
	 */
	public function ViewerInitStart($aParams) {
		$bIsNeed=MobileDetect::IsNeedShowMobile();
		if ($bIsNeed) {
			Config::Set('view.skin','mobile');
		}
	}

	/**
	 * Инициализация
	 */
	public function LangInitStart() {
		$bIsNeed=MobileDetect::IsNeedShowMobile();
		if ($bIsNeed) {
			Config::Set('view.skin','mobile');
		}
	}

	public function MenuItem() {
		if (Config::Get('view.skin')!='mobile') {
			return $this->Viewer_Fetch(Plugin::GetTemplatePath(__CLASS__).'inject.navigate-item.tpl');
		}
	}

	public function WhoisActivityItem($aParams) {
		if (Config::Get('view.skin')=='mobile') {
			/**
			 * Получаем последний топик пользователя
			 */
			$oUser=$aParams['oUserProfile'];
			$oTopic=$this->PluginMobiletpl_Main_GetTopicLastbyUserId($oUser->getId());
			$this->Viewer_Assign('oTopicUserProfileLast',$oTopic);
			return $this->Viewer_Fetch(Plugin::GetTemplatePath(__CLASS__).'inject.profile.whois.activity-item.tpl');
		}
	}

	public function TopicShow($aParams) {
		$oTopic=$aParams['oTopic'];
		/**
		 * Если активен плагин "ViewCount", то ничего не делаем
		 */
		$aPlugins=Engine::getInstance()->GetPlugins();
		if (array_key_exists('viewcount',$aPlugins)) {
			return;
		}
		/**
		 * Если топик просматривает его автор - пропускаем
		 */
		$oUserCurrent=$this->User_GetUserCurrent();
		if ($oUserCurrent and $oUserCurrent->getId()==$oTopic->getUserId()) {
			return;
		}
		$this->PluginMobiletpl_Main_IncTopicCountRead($oTopic);
	}

}
?>