<div class="profile">
	{hook run='profile_top_begin' oUserProfile=$oUserProfile}
	
	<a href="{$oUserProfile->getUserWebPath()}"><img src="{$oUserProfile->getProfileAvatarPath(64)}" alt="avatar" class="avatar" itemprop="photo" /></a>
	
	{*<div id="vote_area_user_{$oUserProfile->getId()}" class="vote {if $oUserProfile->getRating()>=0}vote-count-positive{else}vote-count-negative{/if} {if $oVote} voted {if $oVote->getDirection()>0}voted-up{elseif $oVote->getDirection()<0}voted-down{/if}{/if}">
		<div class="vote-label">{$aLang.user_rating}</div>
		<a href="#" class="vote-up" onclick="return ls.vote.vote({$oUserProfile->getId()},this,1,'user');"></a>
		<a href="#" class="vote-down" onclick="return ls.vote.vote({$oUserProfile->getId()},this,-1,'user');"></a>
		<div id="vote_total_user_{$oUserProfile->getId()}" class="vote-count count" title="{$aLang.user_vote_count}: {$oUserProfile->getCountVote()}">{if $oUserProfile->getRating() > 0}+{/if}{$oUserProfile->getRating()}</div>
	</div>*}


	<div class="user-profile-rating-wrapper">
		<span class="user-profile-rating"><i class="icon-rating"></i> {$oUserProfile->getRating()}</span>
		<span class="user-profile-rating user-profile-strength"><i class="icon-strength"></i> {$oUserProfile->getSkill()}</span>
	</div>
	
	<h2 class="page-header user-login word-wrap {if !$oUserProfile->getProfileName()}no-user-name{/if}" itemprop="nickname">{$oUserProfile->getLogin()}</h2>
	
	{if $oUserProfile->getProfileName()}
		<p class="user-name" itemprop="name">{$oUserProfile->getProfileName()|escape:'html'}</p>
	{/if}
	
	{hook run='profile_top_end' oUserProfile=$oUserProfile}
</div>

{if $oUserCurrent && $oUserCurrent->getId() != $oUserProfile->getId()}
	<ul class="profile-actions clearfix">
		<li><a href="#" class="icon-friend"></a></li>
		<li><a href="{router page='talk'}add/?talk_users={$oUserProfile->getLogin()}" class="icon-send-message"></a></li>
		<li class="profile-actions-vote"><a href="#" class="icon-vote"></a></li>
	</ul>
{/if}

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