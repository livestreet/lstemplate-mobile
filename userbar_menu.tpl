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

		<ul class="userbar-menu-items">
			{hook run='profile_sidebar_menu_item_first' oUserProfile=$oUserProfile}

			<li class="userbar-item" {if $sAction=='profile' && ($aParams[0]=='whois' or $aParams[0]=='')}class="active"{/if}>
				<a href="#" onclick="jQuery('#userbar-submit-menu').slideToggle(); return false;"><div class="holder"><i class="icon-profile-submit-white"></i></div>{$aLang.block_create}</a>
			</li>
			
			<ul class="userbar-submit-menu" id="userbar-submit-menu">
				{if $iUserCurrentCountTopicDraft}
					<li class="write-item-type-draft">
						<i class="icon-submit-topic-userbar"></i>
						<a href="{router page='topic'}saved/" class="write-item-link">{$aLang.topic_menu_saved} ({$iUserCurrentCountTopicDraft})</a>
					</li>
				{/if}
				<li class="write-item-type-topic">
					<i class="icon-submit-topic-userbar"></i>
					<a href="{router page='topic'}add" class="write-item-link">{$aLang.block_create_topic_topic}</a>
				</li>
				<li class="write-item-type-blog">
					<i class="icon-submit-blog-userbar"></i>
					<a href="{router page='blog'}add" class="write-item-link">{$aLang.block_create_blog}</a>
				</li>
				<li class="write-item-type-message">
					<i class="icon-submit-message-userbar"></i>
					<a href="{router page='talk'}add" class="write-item-link">{$aLang.block_create_talk}</a>
				</li>
				{hook run='write_item'}
			</ul>
			
			<li class="userbar-item userbar-item-messages {if $sAction=='talk'}active{/if}">
				<a href="{router page='talk'}"><div class="holder"><i class="icon-profile-messages-white"></i></div>{$aLang.talk_menu_inbox}</a>
				{if $iUserCurrentCountTalkNew} 
					<a href="{router page='talk'}inbox/new" class="userbar-item-messages-number">+{$iUserCurrentCountTalkNew}</a>
				{/if}
			</li>
			<li class="userbar-item {if $sAction=='profile' && ($aParams[0]=='whois' or $aParams[0]=='')}active{/if}">
				<a href="{$oUserCurrent->getUserWebPath()}"><div class="holder"><i class="icon-profile-profile-white"></i></div>{$aLang.user_menu_profile_whois}</a>
			</li>
			<li class="userbar-item {if $sAction=='profile' && $aParams[0]=='wall'}active{/if}">
				<a href="{$oUserCurrent->getUserWebPath()}wall/"><div class="holder"><i class="icon-profile-wall-white"></i></div>{$aLang.user_menu_profile_wall}{if ($iCountWallUserCurrent)>0} ({$iCountWallUserCurrent}){/if}</a>
			</li>
			<li class="userbar-item {if $sAction=='profile' && $aParams[0]=='created'}active{/if}">
				<a href="{$oUserCurrent->getUserWebPath()}created/topics/"><div class="holder"><i class="icon-profile-submited-white"></i></div>{$aLang.user_menu_publication}{if ($iCountCreatedUserCurrent)>0} ({$iCountCreatedUserCurrent}){/if}</a>
			</li>
			<li class="userbar-item {if $sAction=='profile' && $aParams[0]=='favourites'}active{/if}">
				<a href="{$oUserCurrent->getUserWebPath()}favourites/topics/"><div class="holder"><i class="icon-profile-favourites-white"></i></div>{$aLang.user_menu_profile_favourites}{if ($iCountFavouriteUserCurrent)>0} ({$iCountFavouriteUserCurrent}){/if}</a>
			</li>
			<li class="userbar-item {if $sAction=='profile' && $aParams[0]=='friends'}active{/if}">
				<a href="{$oUserCurrent->getUserWebPath()}friends/"><div class="holder"><i class="icon-profile-friends-white"></i></div>{$aLang.user_menu_profile_friends}{if ($iCountFriendsUserCurrent)>0} ({$iCountFriendsUserCurrent}){/if}</a>
			</li>
			<li class="userbar-item {if $sAction=='profile' && $aParams[0]=='stream'}active{/if}">
				<a href="{$oUserCurrent->getUserWebPath()}stream/"><div class="holder"><i class="icon-profile-activity-white"></i></div>{$aLang.user_menu_profile_stream}</a>
			</li>
			<li class="userbar-item {if $sAction=='settings'}active{/if}">
				<a href="{router page='settings'}"><div class="holder"><i class="icon-profile-settings-white"></i></div>{$aLang.settings_menu}</a>
			</li>

			{hook run='profile_sidebar_menu_item_last' oUserProfile=$oUserProfile}

			<li class="userbar-item"><a href="{router page='login'}exit/?security_ls_key={$LIVESTREET_SECURITY_KEY}">{$aLang.exit}</a></li>
		</ul>
	</div>
</aside>