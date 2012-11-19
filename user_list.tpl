{if $aUsersList}
	<table class="table table-users">
		<tbody>
			{foreach from=$aUsersList item=oUserList}
				{assign var="oSession" value=$oUserList->getSession()}
				{assign var="oUserNote" value=$oUserList->getUserNote()}
				<tr>
					<td class="cell-name">
						<div class="user-info">
							<a href="{$oUserList->getUserWebPath()}"><img src="{$oUserList->getProfileAvatarPath(48)}" alt="avatar" class="avatar" /></a>
							<h3 class="word-wrap"><a href="{$oUserList->getUserWebPath()}"><span>{$oUserList->getLogin()}</span></a></h3>
							
							<p>
								<span class="user-profile-rating"><i class="icon-rating"></i> {$oUserList->getRating()}</span>
								<span class="user-profile-rating user-profile-strength"><i class="icon-strength"></i> {$oUserList->getSkill()}</span>
								{if $oUserCurrent && $oUserNote}<i class="icon-note"></i>{/if}
							</p>
						</div>
					</td>
					<td class="cell-actions">
						{if $oUserCurrent}
							<a href="{router page='talk'}add/?talk_users={$oUserList->getLogin()}" class="icon-send-message"></a>
						{/if}
					</td>
				</tr>
			{/foreach}
		</tbody>
	</table>
{else}
	{if $sUserListEmpty}
		{$sUserListEmpty}
	{else}
		{$aLang.user_empty}
	{/if}
{/if}


{include file='paging.tpl' aPaging=$aPaging}