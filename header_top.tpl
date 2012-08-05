<nav id="userbar" class="clearfix">
	{*<form action="{router page='search'}topics/" class="search">
		<input type="text" placeholder="{$aLang.search}" maxlength="255" name="q" class="input-text">
		<input type="submit" value="" title="{$aLang.search_submit}" class="input-submit icon icon-search">
	</form>*}

	<h1 class="site-name"><a href="{cfg name='path.root.web'}">{cfg name='view.name'}</a></h1>

	{hook run='userbar_nav'}
	
	<ul class="nav-userbar">
		{if $oUserCurrent}
			<li class="avatar">
				<a href="{$oUserCurrent->getUserWebPath()}" class="username">
					<img src="{$oUserCurrent->getProfileAvatarPath(48)}" alt="avatar" />
				</a>
			</li>
			{*
			<li class="nav-userbar-username">
				<a href="{$oUserCurrent->getUserWebPath()}" class="username">
					<img src="{$oUserCurrent->getProfileAvatarPath(24)}" alt="avatar" class="avatar" />
					{$oUserCurrent->getLogin()}
				</a>
			</li>
			<li><a href="{router page='topic'}add/" class="write" id="modal_write_show">{$aLang.block_create}</a></li>
			<li><a href="{$oUserCurrent->getUserWebPath()}favourites/topics/">{$aLang.user_menu_profile_favourites}</a></li>
			<li><a href="{router page='talk'}" {if $iUserCurrentCountTalkNew}class="new-messages"{/if} id="new_messages" title="{if $iUserCurrentCountTalkNew}{$aLang.user_privat_messages_new}{/if}">{$aLang.user_privat_messages}{if $iUserCurrentCountTalkNew} ({$iUserCurrentCountTalkNew}){/if}</a></li>
			<li><a href="{router page='settings'}profile/">{$aLang.user_settings}</a></li>
			{hook run='userbar_item'}
			<li><a href="{router page='login'}exit/?security_ls_key={$LIVESTREET_SECURITY_KEY}">{$aLang.exit}</a></li>
			*}
		{else}
			{hook run='userbar_item'}
			<li><a href="{router page='login'}">{$aLang.user_login_submit}</a></li>
			{*<li><a href="{router page='registration'}" class="js-registration-form-show">{$aLang.registration_submit}</a></li>*}
		{/if}
	</ul>
</nav>


{*
	{hook run='header_banner_begin'}
	{hook run='header_banner_end'}
*}