<?php

/**
 * Этот файл необходимо скопировать в каталог /include/ вашего сайта
 * Суть его в том, чтобы подменять список активированных плагинов, это позволяет избежать потенциальных ошибок в мобильном шаблоне
 */

/**
 * Подключаем файл инициализации мобильного шаблона
 */
$sFileInit=Config::get('path.root.server').'/plugins/mobiletpl/extra/init.php';
if (file_exists($sFileInit)) {
	require_once($sFileInit);
}