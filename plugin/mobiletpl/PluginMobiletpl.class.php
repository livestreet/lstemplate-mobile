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

/**
 * Запрещаем напрямую через браузер обращение к этому файлу.
 */
if (!class_exists('Plugin')) {
	die('Hacking attempt!');
}

class PluginMobiletpl extends Plugin {

	protected $aInherits=array(

	);

	public function __construct() {
		/**
		 * Если сейчас активна мобильная версия, то отключаем доступ к админке
		 */
		if (Config::Get('sys.plugins.activation_file')=='plugins-mobile.dat') {
			$this->aInherits=array(
				'action' =>array(
					'ActionAdmin'
				),
			);
		}
	}
	
	/**
	 * Активация плагина	 
	 */
	public function Activate() {
		$bError=true;
		/**
		 * Проверяем наличие файла /plugins/plugins-mobile.dat
		 */
		$sPluginFile=Config::get('path.root.server').'/plugins/plugins-mobile.dat';
		if (!file_exists($sPluginFile)) {
			/**
			 * Если файла нет, то пытаемся его создать
			 */
			$aPluginsActive=array('mobiletpl');
			/**
			 * Записываем данные в файл PLUGINS.DAT
			 */
			if (@file_put_contents($sPluginFile, implode(PHP_EOL,$aPluginsActive))!==false) {
				$bError=false;
			} else {
				$this->Message_AddError('Ошибка активации плагина Mobile Template. Необходимо дать права на запись в каталог /plugins/',$this->Lang_Get('error'),true);
				return false;
			}
		} else {
			$bError=false;
		}
		if (!$bError) {
			/**
			 * Проверяем наличие файла /include/mobile.php
			 */
			$sFile=Config::get('path.root.server').'/include/mobile.php';
			if (!file_exists($sFile)) {
				/**
				 * Пытаемся скопировать необходимый файл
				 */
				if (@copy(dirname(__FILE__).'/extra/mobile.php',$sFile)) {
					return true;
				} else {
					$this->Message_AddError('Ошибка активации плагина Mobile Template. Необходимо в каталог /include/ скопировать файл /plugins/mobiletpl/extra/mobile.php',$this->Lang_Get('error'),true);
					return false;
				}
			} else {
				return true;
			}
		}
		return false;
	}
	
	/**
	 * Инициализация плагина
	 */
	public function Init() {

	}
}
?>