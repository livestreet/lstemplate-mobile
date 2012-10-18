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
								<span class="rating"><i class="icon-rating"></i> {$oUserList->getRating()}</span>
								<span class="strength"><i class="icon-strength"></i> {$oUserList->getSkill()}</span>
								{if $oUserCurrent && $oUserNote}<i class="icon-note"></i>{/if}
							</p>
						</div>
					</td>
					<td class="cell-actions">
						{if $oUserCurrent}
							{strip}
								<a href="{router page='talk'}add/?talk_users={$oUserList->getLogin()}" class="icon-send-message"></a>
								<a href="#" class="icon-friend"></a>
							{/strip}
						{/if}
					</td>
				</tr>
			{/foreach}
		</tbody>
	</table>
{else}
	<div class="wrapper">
		{if $sUserListEmpty}
			{$sUserListEmpty}
		{else}
			{$aLang.user_empty}
		{/if}
	</div>
{/if}


{include file='paging.tpl' aPaging=$aPaging}