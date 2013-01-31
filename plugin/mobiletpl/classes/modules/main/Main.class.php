<?php
/*-------------------------------------------------------
*
*   LiveStreet Engine Social Networking
*   Copyright © 2008 Mzhelskiy Maxim
*
*--------------------------------------------------------
*
*   Official site: www.livestreet.ru
*   Contact e-mail: rus.engine@gmail.com
*
*   GNU General Public License, version 2:
*   http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
*
---------------------------------------------------------
*/

class PluginMobiletpl_ModuleMain extends Module {

	protected $oMapper;

	public function Init() {
		$this->oMapper=Engine::GetMapper(__CLASS__);
	}

	/**
	 * Проверяет является ли текущий шаблон мобильным
	 *
	 * @return bool
	 */
	public function IsMobileTemplate() {
		return MobileDetect::IsMobileTemplate(false);
	}

	public function GetTopicLastbyUserId($iUserId) {
		$aTopicTypes=$this->Topic_GetTopicTypes();
		$aFilter=array(
			'blog_type' => array(
				'personal',
				'open'
			),
			'topic_publish' => 1,
			'user_id'  => $iUserId
		);
		if ($aTopicTypes) {
			$aFilter['topic_type']=$aTopicTypes;
		}
		$aResult=$this->Topic_GetTopicsByFilter($aFilter,1,1);
		if ($aResult['collection']) {
			return array_shift($aResult['collection']);
		}
		return null;
	}

	public function IncTopicCountRead($oTopic) {
		$this->oMapper->IncTopicCountRead($oTopic->getId());
		//чистим зависимые кеши
		$this->Cache_Clean(Zend_Cache::CLEANING_MODE_MATCHING_TAG,array('topic_update',"topic_update_user_{$oTopic->getUserId()}"));
		$this->Cache_Delete("topic_{$oTopic->getId()}");
	}

}
?>