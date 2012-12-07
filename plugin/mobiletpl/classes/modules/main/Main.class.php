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
	protected $sApiUrl='http://phd.yandex.net/detect';
	protected $aHeaderForDetect=array(
		'user-agent','profile','wap-profile','x-wap-profile','x-operamini-phone-ua'
	);

	public function Init() {
		$this->oMapper=Engine::GetMapper(__CLASS__);
	}
	/**
	 * Выполняет запрос к API сервиса
	 *
	 * @param array $aRequest	Список параметров
	 *
	 * @return bool|array
	 */
	public function RequestApi($aRequest) {
		$s='';
		if (is_string($aRequest) or count($aRequest)){
			$s='?'.(is_array($aRequest) ? http_build_query($aRequest,'','&') : $aRequest);
		}
		if ($sReturn=@file_get_contents($this->sApiUrl.'/'.$s)) {
			return $sReturn;
		}
		return false;
	}

	public function DetectMobileDevice() {
		$aRequest=array();
		if (isset($_SERVER)) {
			$aServer=$_SERVER;
		} else {
			$aServer=array();
		}

		foreach ($aServer as $sKey => $sValue) {
			if (strpos($sKey,'HTTP_')===0) {
				$sKey=strtolower(strtr(substr($sKey, 5), '_', '-'));
				if (in_array($sKey,$this->aHeaderForDetect)) {
					$aRequest[$sKey]=$sValue;
				}
			}
		}
		$aRequest['user-agent']='Alcatel-CTH3/1.0 UP.Browser/6.2.ALCATEL MMP/1.0';
		$sResult=$this->RequestApi($aRequest);
		$oXml=@simplexml_load_string($sResult);
		if ((is_object($oXml) == false)) {
			return false;
		}
		if ($oXml->name and (int)$oXml->screenx<1024) {
			return true;
		}
		return false;
	}

	public function IsNeedShowMobile() {
		$bDetect=$this->DetectMobileDevice();

		return $bDetect;
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