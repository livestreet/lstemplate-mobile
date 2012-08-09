<nav id="userbar" class="clearfix">
	{*<form action="{router page='search'}topics/" class="search">
		<input type="text" placeholder="{$aLang.search}" maxlength="255" name="q" class="input-text">
		<input type="submit" value="" title="{$aLang.search_submit}" class="input-submit icon icon-search">
	</form>*}

	<h1 class="site-name"><a href="{cfg name='path.root.web'}">{cfg name='view.name'}</a></h1>

	{hook run='userbar_nav'}

	{if $oUserCurrent}
		<div class="userbar-avatar">
			<a href="{$oUserCurrent->getUserWebPath()}" class="username">
				<img src="{$oUserCurrent->getProfileAvatarPath(48)}" alt="avatar" />
			</a>
		</div>
	{/if}
	
	<ul class="nav-userbar">
		<li class="userbar-search"><a href="{router page='search'}"></a></li>
		{if $oUserCurrent}
			<li class="userbar-settings"><a href="{router page='settings'}profile/" title="{$aLang.user_settings}"></a></li>
			<li class="userbar-add"><a href="{router page='topic'}add/" title="{$aLang.block_create}"></a></li>
			{hook run='userbar_item'}
		{else}
			{hook run='userbar_item'}
			<li class="userbar-settings"><a href="{router page='login'}"></a></li>
			{*<li><a href="{router page='registration'}" class="js-registration-form-show">{$aLang.registration_submit}</a></li>*}
		{/if}
	</ul>
</nav>


{*
	{hook run='header_banner_begin'}
	{hook run='header_banner_end'}
*}