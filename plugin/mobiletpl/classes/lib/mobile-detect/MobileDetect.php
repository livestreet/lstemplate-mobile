<?php

class MobileDetect {

	static protected $sApiUrl='http://phd.yandex.net/detect';
	static protected $aHeaderForDetect=array(
		'user-agent','profile','wap-profile','x-wap-profile','x-operamini-phone-ua'
	);
	static protected $bIsNeedShowMobile=null;
	/**
	 * Выполняет запрос к API сервиса
	 *
	 * @param array $aRequest	Список параметров
	 *
	 * @return bool|array
	 */
	static public function RequestApi($aRequest) {
		$s='';
		if (is_string($aRequest) or count($aRequest)){
			$s='?'.(is_array($aRequest) ? http_build_query($aRequest,'','&') : $aRequest);
		}
		if ($sReturn=@file_get_contents(self::$sApiUrl.'/'.$s)) {
			return $sReturn;
		}
		return false;
	}

	/**
	 * Определение типа устройства - мобильное или нет
	 *
	 * @return bool
	 */
	static public function DetectMobileDevice() {
		$aRequest=array();
		if (isset($_SERVER)) {
			$aServer=$_SERVER;
		} else {
			$aServer=array();
		}

		foreach ($aServer as $sKey => $sValue) {
			if (strpos($sKey,'HTTP_')===0) {
				$sKey=strtolower(strtr(substr($sKey, 5), '_', '-'));
				if (in_array($sKey,self::$aHeaderForDetect)) {
					$aRequest[$sKey]=$sValue;
				}
			}
		}
		//$aRequest['user-agent']='Alcatel-CTH3/1.0 UP.Browser/6.2.ALCATEL MMP/1.0';
		$sResult=self::RequestApi($aRequest);
		$oXml=@simplexml_load_string($sResult);
		if ((is_object($oXml) == false)) {
			return false;
		}
		if ($oXml->name and (int)$oXml->screenx<1024) {
			return true;
		}
		return false;
	}

	static public function IsNeedShowMobile() {
		if (!is_null(self::$bIsNeedShowMobile)) {
			return self::$bIsNeedShowMobile;
		}
		/**
		 * Принудительно включаем мобильную версию
		 */
		if (getRequest('force-mobile',false,'get')=='on') {
			setcookie('use_mobile',1,time()+60*60*24*30,Config::Get('sys.cookie.path'),Config::Get('sys.cookie.host'),false);
			return self::$bIsNeedShowMobile=true;
		}
		/**
		 * Принудительно включаем полную версию
		 */
		if (getRequest('force-mobile',false,'get')=='off') {
			setcookie('use_mobile',0,time()+60*60*24*30,Config::Get('sys.cookie.path'),Config::Get('sys.cookie.host'),false);
			return self::$bIsNeedShowMobile=false;
		}
		/**
		 * Пользователь уже использует мобильную или полную версию
		 */
		if (isset($_COOKIE['use_mobile'])) {
			if ($_COOKIE['use_mobile']) {
				return self::$bIsNeedShowMobile=true;
			} else {
				return self::$bIsNeedShowMobile=false;
			}
		}
		/**
		 * Запускаем авто-определение мобильного клиента
		 */
		if (self::DetectMobileDevice()) {
			setcookie('use_mobile',1,time()+60*60*24*30,Config::Get('sys.cookie.path'),Config::Get('sys.cookie.host'),false);
			return self::$bIsNeedShowMobile=true;
		} else {
			setcookie('use_mobile',0,time()+60*60*24*30,Config::Get('sys.cookie.path'),Config::Get('sys.cookie.host'),false);
			return self::$bIsNeedShowMobile=false;
		}
	}

	static public function IsMobileTemplate($bHard=true) {
		if ($bHard) {
			return self::IsNeedShowMobile();
		} else {
			return Config::Get('plugin.mobiletpl.template') && Config::Get('view.skin')==Config::Get('plugin.mobiletpl.template');
		}
	}
}
