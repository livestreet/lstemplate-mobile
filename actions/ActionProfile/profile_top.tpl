<div class="profile">
	{hook run='profile_top_begin' oUserProfile=$oUserProfile}
	
	<a href="{$oUserProfile->getUserWebPath()}"><img src="{$oUserProfile->getProfileAvatarPath(64)}" alt="avatar" class="avatar" itemprop="photo" /></a>
	
	{if $oUserProfile->isOnline()}<div class="status {if $oUserProfile->isOnline()}status-online{else}status-offline{/if}"></div>{/if}

	<div class="user-profile-rating-wrapper">
		<span class="user-profile-rating"><i class="icon-rating"></i> <span id="vote_total_user_alt_{$oUserProfile->getId()}">{$oUserProfile->getRating()}</span></span>
		<span class="user-profile-rating user-profile-strength"><i class="icon-strength"></i> {$oUserProfile->getSkill()}</span>
	</div>
	
	<h2 class="page-header user-login word-wrap {if !$oUserProfile->getProfileName()}no-user-name{/if}" itemprop="nickname">{$oUserProfile->getLogin()}</h2>
	
	{if $oUserProfile->getProfileName()}
		<p class="user-name" itemprop="name">{$oUserProfile->getProfileName()|escape:'html'}</p>
	{/if}
	
	{hook run='profile_top_end' oUserProfile=$oUserProfile}
</div>


{if $oUserCurrent && $oUserCurrent->getId() != $oUserProfile->getId()}
	<ul class="profile-actions full-width clearfix" id="profile_actions">
		{include file='actions/ActionProfile/friend_item.tpl' oUserFriend=$oUserProfile->getUserFriend()}
		<li><a href="{router page='talk'}add/?talk_users={$oUserProfile->getLogin()}" class="icon-send-message"></a></li>
		
		{if $oUserCurrent && $oUserProfile->getId() != $oUserCurrent->getId()}
			<li class="vote-result vote-no-rating
				{if $oVote}
					{if $oUserProfile->getRating() > 0}
						vote-count-positive
					{elseif $oUserProfile->getRating() < 0}
						vote-count-negative
					{elseif $oUserProfile->getRating() == 0}
						vote-count-zero
					{/if}
				{/if}

				{if $oVote} 
					voted
															
					{if $oVote->getDirection() > 0}
						voted-up
					{elseif $oVote->getDirection() < 0}
						voted-down
					{/if}
				{/if}"

				id="vote_total_user_{$oUserProfile->getId()}"

				{if $oUserCurrent && !$oVote}
					onclick="ls.tools.slide($('#vote_area_user_{$oUserProfile->getId()}'), $(this));"
				{/if}>
			</li>
		{/if}
	</ul>
{/if}


{if !$oUserFriend}
	<div id="add_friend_form" class="slide slide-bg-grey mb-10">
		<header class="modal-header">
			<h3>{$aLang.profile_add_friend}</h3>
			<a href="#" class="close jqmClose"></a>
		</header>

		<form onsubmit="return ls.user.addFriend(this,{$oUserProfile->getId()},'add');" class="modal-content">
			<p><label for="add_friend_text">{$aLang.user_friend_add_text_label}</label>
			<textarea id="add_friend_text" rows="3" class="input-text input-width-full"></textarea></p>

			<button type="submit" class="button button-primary">{$aLang.user_friend_add_submit}</button>
		</form>
	</div>
{/if}


<div id="vote_area_user_{$oUserProfile->getId()}" class="vote vote-blog">
	<div class="vote-item vote-up" onclick="return ls.vote.vote({$oUserProfile->getId()},this,1,'user');"><i></i></div>
	<div class="vote-item vote-down" onclick="return ls.vote.vote({$oUserProfile->getId()},this,-1,'user');"><i></i></div>
</div>


<ul class="nav-foldable">
	{hook run='profile_sidebar_menu_item_first' oUserProfile=$oUserProfile}
	<li {if $sAction=='profile' && ($aParams[0]=='whois' or $aParams[0]=='')}class="active"{/if}><a href="{$oUserProfile->getUserWebPath()}">{$aLang.user_menu_profile_whois}</a></li>
	<li {if $sAction=='profile' && $aParams[0]=='wall'}class="active"{/if}><a href="{$oUserProfile->getUserWebPath()}wall/">{$aLang.user_menu_profile_wall}{if ($iCountWallUser)>0} ({$iCountWallUser}){/if}</a></li>
	<li {if $sAction=='profile' && $aParams[0]=='created'}class="active"{/if}><a href="{$oUserProfile->getUserWebPath()}created/topics/">{$aLang.user_menu_publication}{if ($iCountCreated)>0} ({$iCountCreated}){/if}</a></li>
	<li {if $sAction=='profile' && $aParams[0]=='favourites'}class="active"{/if}><a href="{$oUserProfile->getUserWebPath()}favourites/topics/">{$aLang.user_menu_profile_favourites}{if ($iCountFavourite)>0} ({$iCountFavourite}){/if}</a></li>
	<li {if $sAction=='profile' && $aParams[0]=='friends'}class="active"{/if}><a href="{$oUserProfile->getUserWebPath()}friends/">{$aLang.user_menu_profile_friends}{if ($iCountFriendsUser)>0} ({$iCountFriendsUser}){/if}</a></li>
	<li {if $sAction=='profile' && $aParams[0]=='stream'}class="active"{/if}><a href="{$oUserProfile->getUserWebPath()}stream/">{$aLang.user_menu_profile_stream}</a></li>
	
	{if $oUserCurrent and $oUserCurrent->getId() == $oUserProfile->getId()}
		<li {if $sAction=='talk'}class="active"{/if}><a href="{router page='talk'}">{$aLang.talk_menu_inbox}{if $iUserCurrentCountTalkNew} ({$iUserCurrentCountTalkNew}){/if}</a></li>
		<li {if $sAction=='settings'}class="active"{/if}><a href="{router page='settings'}">{$aLang.settings_menu}</a></li>
	{/if}
	{hook run='profile_sidebar_menu_item_last' oUserProfile=$oUserProfile}
</ul>