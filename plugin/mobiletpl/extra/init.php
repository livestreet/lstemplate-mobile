<?php

if (!class_exists('MobileDetect')) {
	require_once(dirname(dirname(__FILE__)).'/classes/lib/mobile-detect/MobileDetect.php');
}

$sPluginDir=Config::get('path.root.server').'/plugins';

if ($aPlugins=func_list_plugins()) {
	foreach($aPlugins as $sPlugin) {
		if (strtolower($sPlugin)=='mobiletpl') {
			/**
			 * Активен плагин мобильного шаблона
			 */
			if (MobileDetect::IsNeedShowMobile()) {
				/**
				 * Переопределяем файл списка плагинов на новый - /plugins/plugins-mobile.dat
				 * В нем будет активен только один плагин - mobiletpl
				 * При необходимости пользователь может добавить плагины сам
				 */
				if (file_exists($sPluginDir.'/plugins-mobile.dat')) {
					Config::Set('sys.plugins.activation_file','plugins-mobile.dat');
					/**
					 * TODO: Нужно отключить админку в мобильной версии, иначе будет хаос
					 */
				}
			}
			break;
		}
	}
}