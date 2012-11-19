<aside id="userbar" class="userbar-menu">
	<div class="userbar-menu-inner" id="userbar-inner">
		<div class="userbar-menu-user">
			<a href="{$oUserCurrent->getUserWebPath()}"><img src="{$oUserCurrent->getProfileAvatarPath(48)}" alt="avatar" class="avatar" /></a>
			<h3 class="login"><a href="{$oUserCurrent->getUserWebPath()}">{$oUserCurrent->getLogin()}</a></h3>
		</div>

		<div class="userbar-menu-rating-wrapper">
			<span class="user-profile-rating"><i class="icon-rating-grey"></i> {$oUserCurrent->getRating()}</span>
			<span class="user-profile-rating user-profile-strength"><i class="icon-strength"></i> {$oUserCurrent->getSkill()}</span>
		</div>

		<ul class="">
			{hook run='profile_sidebar_menu_item_first' oUserProfile=$oUserProfile}

			<li {if $sAction=='profile' && ($aParams[0]=='whois' or $aParams[0]=='')}class="active"{/if}>
				<a href="{router page='topic'}add"><div class="holder"><i class="icon-profile-submit-white"></i></div>{$aLang.block_create}</a>
			</li>
			<li class="userbar-item-messages {if $sAction=='talk'}active{/if}">
				<a href="{router page='talk'}"><div class="holder"><i class="icon-profile-messages-white"></i></div>{$aLang.talk_menu_inbox}</a>
				{if $iUserCurrentCountTalkNew} 
					<a href="#" class="userbar-item-messages-number">+{$iUserCurrentCountTalkNew}</a>
				{/if}
			</li>
			<li {if $sAction=='profile' && ($aParams[0]=='whois' or $aParams[0]=='')}class="active"{/if}>
				<a href="{$oUserCurrent->getUserWebPath()}"><div class="holder"><i class="icon-profile-profile-white"></i></div>{$aLang.user_menu_profile_whois}</a>
			</li>
			<li {if $sAction=='profile' && $aParams[0]=='wall'}class="active"{/if}>
				<a href="{$oUserCurrent->getUserWebPath()}wall/"><div class="holder"><i class="icon-profile-wall-white"></i></div>{$aLang.user_menu_profile_wall}{if ($iCountWallUser)>0} ({$iCountWallUser}){/if}</a>
			</li>
			<li {if $sAction=='profile' && $aParams[0]=='created'}class="active"{/if}>
				<a href="{$oUserCurrent->getUserWebPath()}created/topics/"><div class="holder"><i class="icon-profile-submited-white"></i></div>{$aLang.user_menu_publication}{if ($iCountCreated)>0} ({$iCountCreated}){/if}</a>
			</li>
			<li {if $sAction=='profile' && $aParams[0]=='favourites'}class="active"{/if}>
				<a href="{$oUserCurrent->getUserWebPath()}favourites/topics/"><div class="holder"><i class="icon-profile-favourites-white"></i></div>{$aLang.user_menu_profile_favourites}{if ($iCountFavourite)>0} ({$iCountFavourite}){/if}</a>
			</li>
			<li {if $sAction=='profile' && $aParams[0]=='friends'}class="active"{/if}>
				<a href="{$oUserCurrent->getUserWebPath()}friends/"><div class="holder"><i class="icon-profile-friends-white"></i></div>{$aLang.user_menu_profile_friends}{if ($iCountFriendsUser)>0} ({$iCountFriendsUser}){/if}</a>
			</li>
			<li {if $sAction=='profile' && $aParams[0]=='stream'}class="active"{/if}>
				<a href="{$oUserCurrent->getUserWebPath()}stream/"><div class="holder"><i class="icon-profile-activity-white"></i></div>{$aLang.user_menu_profile_stream}</a>
			</li>
			<li {if $sAction=='settings'}class="active"{/if}>
				<a href="{router page='settings'}"><div class="holder"><i class="icon-profile-settings-white"></i></div>{$aLang.settings_menu}</a>
			</li>

			{hook run='profile_sidebar_menu_item_last' oUserProfile=$oUserProfile}

			<li><a href="{router page='login'}exit/?security_ls_key={$LIVESTREET_SECURITY_KEY}">{$aLang.exit}</a></li>
		</ul>
	</div>
</aside>