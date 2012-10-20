<!doctype html>

<!--[if lt IE 7]> <html class="no-js ie6 oldie" lang="ru"> <![endif]-->
<!--[if IE 7]>    <html class="no-js ie7 oldie" lang="ru"> <![endif]-->
<!--[if IE 8]>    <html class="no-js ie8 oldie" lang="ru"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="ru"> <!--<![endif]-->

<head>
	{hook run='html_head_begin'}
	
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	
	<title>{$sHtmlTitle}</title>
	
	<meta name="description" content="{$sHtmlDescription}">
	<meta name="keywords" content="{$sHtmlKeywords}">


	<!-- Mobile viewport optimization h5bp.com/ad -->
	<meta name="HandheldFriendly" content="True">
	<meta name="MobileOptimized" content="320">
	<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=yes" name="viewport">

	<!-- Home screen icon  Mathias Bynens mathiasbynens.be/notes/touch-icons -->
	<!-- For iPhone 4 with high-resolution Retina display: -->
	<link rel="apple-touch-icon-precomposed" sizes="114x114" href="{cfg name='path.static.skin'}/images/h/apple-touch-icon.png">
	<!-- For first-generation iPad: -->
	<link rel="apple-touch-icon-precomposed" sizes="72x72" href="{cfg name='path.static.skin'}/images/m/apple-touch-icon.png">
	<!-- For non-Retina iPhone, iPod Touch, and Android 2.1+ devices: -->
	<link rel="apple-touch-icon-precomposed" href="{cfg name='path.static.skin'}/images/l/apple-touch-icon-precomposed.png">
	<!-- For nokia devices: -->
	<link rel="shortcut icon" href="{cfg name='path.static.skin'}/images/l/apple-touch-icon.png">

	<!-- Mobile IE allows us to activate ClearType technology for smoothing fonts for easy reading -->
	<meta http-equiv="cleartype" content="on">


	{$aHtmlHeadFiles.css}
	<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,400italic,600,600italic,700,700italic&subset=latin,cyrillic' rel='stylesheet' type='text/css'>

	<link href="{cfg name='path.static.skin'}/images/favicon.ico?v1" rel="shortcut icon" />
	<link rel="search" type="application/opensearchdescription+xml" href="{router page='search'}opensearch/" title="{cfg name='view.name'}" />

	{if $aHtmlRssAlternate}
		<link rel="alternate" type="application/rss+xml" href="{$aHtmlRssAlternate.url}" title="{$aHtmlRssAlternate.title}">
	{/if}

	{if $sHtmlCanonical}
		<link rel="canonical" href="{$sHtmlCanonical}" />
	{/if}
	
	{if $bRefreshToHome}
		<meta  HTTP-EQUIV="Refresh" CONTENT="3; URL={cfg name='path.root.web'}/">
	{/if}
	
	
	<script type="text/javascript">
		var DIR_WEB_ROOT 			= '{cfg name="path.root.web"}';
		var DIR_STATIC_SKIN 		= '{cfg name="path.static.skin"}';
		var DIR_ROOT_ENGINE_LIB 	= '{cfg name="path.root.engine_lib"}';
		var LIVESTREET_SECURITY_KEY = '{$LIVESTREET_SECURITY_KEY}';
		var SESSION_ID				= '{$_sPhpSessionId}';
		var BLOG_USE_TINYMCE		= '{cfg name="view.tinymce"}';
		
		var TINYMCE_LANG = 'en';
		{if $oConfig->GetValue('lang.current') == 'russian'}
			TINYMCE_LANG = 'ru';
		{/if}

		var aRouter = new Array();
		{foreach from=$aRouter key=sPage item=sPath}
			aRouter['{$sPage}'] = '{$sPath}';
		{/foreach}
	</script>
	
	
	{$aHtmlHeadFiles.js}

	
	<script type="text/javascript">
		var tinyMCE = false;
		ls.lang.load({json var = $aLangJs});
		ls.registry.set('comment_max_tree','{cfg name="module.comment.max_tree"}');
	</script>
	
	
	{if {cfg name='view.grid.type'} == 'fluid'}
		<style>
			#container {
				min-width: {cfg name='view.grid.fluid_min_width'}px;
				max-width: {cfg name='view.grid.fluid_max_width'}px;
			}
		</style>
	{else}
		<style>
			#container {
				width: {cfg name='view.grid.fixed_width'}px;
			}
		</style>
	{/if}
	
	
	{hook run='html_head_end'}
</head>



{if $oUserCurrent}
	{assign var=body_classes value=$body_classes|cat:' ls-user-role-user'}
	
	{if $oUserCurrent->isAdministrator()}
		{assign var=body_classes value=$body_classes|cat:' ls-user-role-admin'}
	{/if}
{else}
	{assign var=body_classes value=$body_classes|cat:' ls-user-role-guest'}
{/if}

{if !$oUserCurrent or ($oUserCurrent and !$oUserCurrent->isAdministrator())}
	{assign var=body_classes value=$body_classes|cat:' ls-user-role-not-admin'}
{/if}


<body class="{$body_classes} width-{cfg name='view.grid.type'}">
	{hook run='body_begin'}
	
	
	{if $oUserCurrent}
		{include file='window_favourite_form_tags.tpl'}
	{/if}
	

	<div id="container" class="{hook run='container_class'}">
		{include file='header_top.tpl'}
		{include file='nav.tpl'}

		<div id="content" role="main" 
			class="{if $noBg}no-bg{/if} 
				   {if $sidebarPosition == 'left'}content-right{/if} {hook run='wrapper_class'}"
			{if $sMenuItemSelect=='profile'}itemscope itemtype="http://data-vocabulary.org/Person"{/if}>
			
			{* {include file='nav_content.tpl'} *}
			{include file='system_message.tpl'}
			
			{hook run='content_begin'}