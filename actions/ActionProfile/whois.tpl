{assign var="sMenuItemSelect" value='profile'}
{include file='header.tpl'}

{assign var="oSession" value=$oUserProfile->getSession()}
{assign var="oVote" value=$oUserProfile->getVote()}
{assign var="oGeoTarget" value=$oUserProfile->getGeoTarget()}



{include file='actions/ActionProfile/profile_top.tpl'}
<br />

{assign var="aUserFieldValues" value=$oUserProfile->getUserFieldValues(true,array(''))}

{if $oUserProfile->getProfileSex()!='other' || $oUserProfile->getProfileBirthday() || $oGeoTarget || count($aUserFieldValues)}
<div class="table-profile-info-wrapper">
	<h2 class="header-table">{$aLang.profile_privat}</h2>
	
	
	<table class="table table-profile-info">		
		{if $oUserProfile->getProfileSex()!='other'}
			<tr>
				<td class="cell-label">{$aLang.profile_sex}:</td>
				<td>
					{if $oUserProfile->getProfileSex()=='man'}
						{$aLang.profile_sex_man}
					{else}
						{$aLang.profile_sex_woman}
					{/if}
				</td>
			</tr>
		{/if}
			
			
		{if $oUserProfile->getProfileBirthday()}
			<tr>
				<td class="cell-label">{$aLang.profile_birthday}:</td>
				<td>{date_format date=$oUserProfile->getProfileBirthday() format="j F Y"}</td>
			</tr>
		{/if}
		
		
		{if $oGeoTarget}
			<tr>
				<td class="cell-label">{$aLang.profile_place}:</td>
				<td itemprop="address" itemscope itemtype="http://data-vocabulary.org/Address">
					{if $oGeoTarget->getCountryId()}
						<a href="{router page='people'}country/{$oGeoTarget->getCountryId()}/" itemprop="country-name">{$oUserProfile->getProfileCountry()|escape:'html'}</a>{if $oGeoTarget->getCityId()},{/if}
					{/if}
					
					{if $oGeoTarget->getCityId()}
						<a href="{router page='people'}city/{$oGeoTarget->getCityId()}/" itemprop="locality">{$oUserProfile->getProfileCity()|escape:'html'}</a>
					{/if}
				</td>
			</tr>
		{/if}

		{if $aUserFieldValues}
			{foreach from=$aUserFieldValues item=oField}
				<tr>
					<td class="cell-label"><i class="icon-contact icon-contact-{$oField->getName()}"></i> {$oField->getTitle()|escape:'html'}:</td>
					<td>{$oField->getValue(true,true)}</td>
				</tr>
			{/foreach}
		{/if}

		{hook run='profile_whois_privat_item' oUserProfile=$oUserProfile}
	</table>
</div>
{/if}

{hook run='profile_whois_item_after_privat' oUserProfile=$oUserProfile}



{if $oUserCurrent && $oUserCurrent->getId() != $oUserProfile->getId()}
	<section class="profile-info-note full-width">
		{if $oUserNote}
			<script type="text/javascript">
				ls.usernote.sText = {json var = $oUserNote->getText()};
			</script>
		{/if}
		
		<h2 class="header-table">{$aLang.profile_note_header}</h2>

		<div id="usernote-note" class="profile-note" {if !$oUserNote}style="display: none;"{/if}>
			<p id="usernote-note-text">
				{if $oUserNote}
					{$oUserNote->getText()}
				{/if}
			</p>
			
			<ul class="actions clearfix">
				<li><a href="#" onclick="return ls.usernote.showForm();" class="link-dotted">{$aLang.user_note_form_edit}</a></li>
				<li><a href="#" onclick="return ls.usernote.remove({$oUserProfile->getId()});" class="link-dotted">{$aLang.user_note_form_delete}</a></li>
			</ul>
		</div>
		
		<div id="usernote-form" style="display: none;">
			<p><textarea rows="4" cols="20" id="usernote-form-text" class="input-text input-width-full"></textarea></p><br />
			<button type="submit" onclick="return ls.usernote.save({$oUserProfile->getId()});" class="button button-primary">{$aLang.user_note_form_save}</button>&nbsp;&nbsp;
			<button type="submit" onclick="return ls.usernote.hideForm();" class="button">{$aLang.user_note_form_cancel}</button>
		</div>
		
		<a href="#" onclick="return ls.usernote.showForm();" id="usernote-button-add" class="link-dotted" {if $oUserNote}style="display:none;"{/if}>{$aLang.user_note_add}</a>
	</section>
{/if}

{if $oUserProfile->getProfileAbout()}					
	<div class="profile-info-about">
		<h2 class="header-table">{$aLang.profile_about}</h2>
		{$oUserProfile->getProfileAbout()}
	</div>
{/if}

{*
<div class="profile-info-photo">
	<a href="{$oUserProfile->getUserWebPath()}"><img src="{$oUserProfile->getProfileFotoPath()}" alt="photo" class="profile-photo" id="foto-img" /></a>
</div>
*}

{assign var="aUserFieldContactValues" value=$oUserProfile->getUserFieldValues(true,array('contact'))}
{if $aUserFieldContactValues}
	<div class="table-profile-info-wrapper">
		<h2 class="header-table">{$aLang.profile_contacts}</h2>
		
		<table class="table table-profile-info">
			{foreach from=$aUserFieldContactValues item=oField}
				<tr>
					<td class="cell-label">{$oField->getTitle()|escape:'html'}:</td>
					<td>{$oField->getValue(true,true)}</td>
				</tr>
			{/foreach}
		</table>
	</div>
{/if}


{assign var="aUserFieldContactValues" value=$oUserProfile->getUserFieldValues(true,array('social'))}
{if $aUserFieldContactValues}
<div class="table-profile-info-wrapper">
	<h2 class="header-table">{$aLang.profile_social}</h2>
	
	<ul class="profile-contacts">
		{foreach from=$aUserFieldContactValues item=oField}
			<li class="contact-{$oField->getName()}">
				{$oField->getValue(true,true)}
			</li>
		{/foreach}
	</ul>
</div>
{/if}



{if $aUsersFriend}
	<div class="table-profile-info-wrapper">
		<h2 class="header-table mb-15"><a href="{$oUserProfile->getUserWebPath()}friends/">{$aLang.profile_friends}</a> {$iCountFriendsUser}</h2>
		
		{include file='user_list_avatar.tpl' aUsersList=$aUsersFriend}
	</div>
{/if}


{hook run='profile_whois_item' oUserProfile=$oUserProfile}


<div class="table-profile-info-wrapper">
	<h2 class="header-table"><a href="{$oUserProfile->getUserWebPath()}stream/">{$aLang.profile_activity}</a></h2>

	<table class="table table-profile-info">
		<tr>
			<td class="cell-label">{$aLang.profile_date_registration}:</td>
			<td>{date_format date=$oUserProfile->getDateRegister()}</td>
		</tr>	
		
		
		{if $oSession}				
			<tr>
				<td class="cell-label">{$aLang.profile_date_last}:</td>
				<td>{date_format date=$oSession->getDateLast()}</td>
			</tr>
		{/if}

		{if $oConfig->GetValue('general.reg.invite') and $oUserInviteFrom}
			<tr>
				<td class="cell-label">{$aLang.profile_invite_from}:</td>
				<td>							       						
					<a href="{$oUserInviteFrom->getUserWebPath()}">{$oUserInviteFrom->getLogin()}</a>&nbsp;         					
				</td>
			</tr>
		{/if}
		
		
		{if $oConfig->GetValue('general.reg.invite') and $aUsersInvite}
			<tr>
				<td class="cell-label">{$aLang.profile_invite_to}:</td>
				<td>
					{foreach from=$aUsersInvite item=oUserInvite}        						
						<a href="{$oUserInvite->getUserWebPath()}">{$oUserInvite->getLogin()}</a>&nbsp; 
					{/foreach}
				</td>
			</tr>
		{/if}
		
		
		{if $aBlogsOwner}
			<tr>
				<td class="cell-label">{$aLang.profile_blogs_self}:</td>
				<td>							
					{foreach from=$aBlogsOwner item=oBlog name=blog_owner}
						<a href="{$oBlog->getUrlFull()}">{$oBlog->getTitle()|escape:'html'}</a>{if !$smarty.foreach.blog_owner.last}, {/if}								      		
					{/foreach}
				</td>
			</tr>
		{/if}
		
		
		{if $aBlogAdministrators}
			<tr>
				<td class="cell-label">{$aLang.profile_blogs_administration}:</td>
				<td>
					{foreach from=$aBlogAdministrators item=oBlogUser name=blog_user}
						{assign var="oBlog" value=$oBlogUser->getBlog()}
						<a href="{$oBlog->getUrlFull()}">{$oBlog->getTitle()|escape:'html'}</a>{if !$smarty.foreach.blog_user.last}, {/if}
					{/foreach}
				</td>
			</tr>
		{/if}
		
		
		{if $aBlogModerators}
			<tr>
				<td class="cell-label">{$aLang.profile_blogs_moderation}:</td>
				<td>
					{foreach from=$aBlogModerators item=oBlogUser name=blog_user}
						{assign var="oBlog" value=$oBlogUser->getBlog()}
						<a href="{$oBlog->getUrlFull()}">{$oBlog->getTitle()|escape:'html'}</a>{if !$smarty.foreach.blog_user.last}, {/if}
					{/foreach}
				</td>
			</tr>
		{/if}
		
		
		{if $aBlogUsers}
			<tr>
				<td class="cell-label">{$aLang.profile_blogs_join}:</td>
				<td>
					{foreach from=$aBlogUsers item=oBlogUser name=blog_user}
						{assign var="oBlog" value=$oBlogUser->getBlog()}
						<a href="{$oBlog->getUrlFull()}">{$oBlog->getTitle()|escape:'html'}</a>{if !$smarty.foreach.blog_user.last}, {/if}
					{/foreach}
				</td>
			</tr>
		{/if}
		
		{hook run='profile_whois_activity_item' oUserProfile=$oUserProfile}
	</table>
</div>

{hook run='profile_whois_item_end' oUserProfile=$oUserProfile}


{include file='footer.tpl'}