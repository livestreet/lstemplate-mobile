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


class PluginMobiletpl_ActionAdmin extends PluginMobiletpl_Inherit_ActionAdmin {

	public function Init() {
		$return=parent::Init();
		if($oUserCurrent=$this->User_GetUserCurrent() and $oUserCurrent->isAdministrator()) {
			$this->Message_AddErrorSingle($this->Lang_Get('plugin.mobiletpl.admin_not_allow'),$this->Lang_Get('error'));
			return Router::Action('error');
		}
		return $return;
	}
}