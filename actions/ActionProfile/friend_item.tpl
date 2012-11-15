{if $oUserFriend and ($oUserFriend->getFriendStatus()==$USER_FRIEND_ACCEPT+$USER_FRIEND_OFFER or $oUserFriend->getFriendStatus()==$USER_FRIEND_ACCEPT+$USER_FRIEND_ACCEPT)}
	<li id="delete_friend_item"><a href="#" class="icon-friend active" title="{$aLang.user_friend_del}" onclick="return ls.user.removeFriend(this,{$oUserProfile->getId()},'del');"></a></li>
{elseif $oUserFriend and $oUserFriend->getStatusTo()==$USER_FRIEND_REJECT and $oUserFriend->getStatusFrom()==$USER_FRIEND_OFFER and $oUserFriend->getUserTo()==$oUserCurrent->getId()}
	<li id="add_friend_item"><a href="#" class="icon-friend" title="{$aLang.user_friend_add}" onclick="return ls.user.addFriend(this,{$oUserProfile->getId()},'accept');"></a></li>
{elseif $oUserFriend and $oUserFriend->getFriendStatus()==$USER_FRIEND_OFFER+$USER_FRIEND_REJECT and $oUserFriend->getUserTo()!=$oUserCurrent->getId()}
	{* <li><i class="icon-friend"></i></li> *}	{* user_friend_offer_reject *}							
{elseif $oUserFriend and $oUserFriend->getFriendStatus()==$USER_FRIEND_OFFER+$USER_FRIEND_NULL and $oUserFriend->getUserFrom()==$oUserCurrent->getId()}
	<li><i class="icon-friend-waiting"></i></li>	{* user_friend_offer_send *}					
{elseif $oUserFriend and $oUserFriend->getFriendStatus()==$USER_FRIEND_OFFER+$USER_FRIEND_NULL and $oUserFriend->getUserTo()==$oUserCurrent->getId()}
	<li id="add_friend_item"><a href="#" class="icon-friend" title="{$aLang.user_friend_add}" onclick="return ls.user.addFriend(this,{$oUserProfile->getId()},'accept');"></a></li>
{elseif !$oUserFriend}
	<li id="add_friend_item"><a href="#" class="icon-friend" title="{$aLang.user_friend_add}" id="add_friend_show" onclick="jQuery('#add_friend_form').slideToggle(); jQuery('#add_friend_form textarea').focus(); return false;"></a></li>
{else}
	<li id="add_friend_item"><a href="#" class="icon-friend" title="{$aLang.user_friend_add}" onclick="return ls.user.addFriend(this,{$oUserProfile->getId()},'link');"></a></li>
{/if}