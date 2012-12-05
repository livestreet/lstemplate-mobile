<?php

class PluginMobiletpl_HookMain extends Hook {

	protected $bIsNeedShowMobile=null;

	public function RegisterHook() {
		$this->AddHook('viewer_init_start', 'ViewerInitStart');
		$this->AddHook('lang_init_start', 'LangInitStart');
		$this->AddHook('template_footer_menu_navigate_item', 'MenuItem');

		if (!class_exists('MobileDetect')) {
			require_once(Plugin::GetPath(__CLASS__).'classes/lib/mobile-detect/MobileDetect.php');
		}
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

}
?>