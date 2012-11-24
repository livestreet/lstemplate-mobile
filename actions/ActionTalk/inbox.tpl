{assign var="sidebarPosition" value='left'}
{include file='header.tpl' noShowSystemMessage=false}

{include file='actions/ActionProfile/profile_top.tpl'}
{include file='menu.talk.tpl'}
<br />

{if $aTalks}
	{include file='actions/ActionTalk/filter.tpl'}

	<form action="{router page='talk'}" method="post" id="form_talks_list">
		<input type="hidden" name="security_ls_key" value="{$LIVESTREET_SECURITY_KEY}" />
		<input type="hidden" name="submit_talk_read" id="form_talks_list_submit_read" value="" />
		<input type="hidden" name="submit_talk_del" id="form_talks_list_submit_del" value="" />

		<div class="action-button-wrapper">
			<span id="talk-action-buttons" style="display: none">
				<button type="submit" onclick="ls.talk.makeReadTalks()" class="button">{$aLang.talk_inbox_make_read}</button>
				<button type="submit" onclick="if (confirm('{$aLang.talk_inbox_delete_confirm}')){ ls.talk.removeTalks() };" class="button">{$aLang.talk_inbox_delete}</button>
			</span>
			<a href="{router page='talk'}add/" class="button button-primary">{$aLang.talk_inbox_new}</a>
		</div>
		
		
		<script>
			jQuery(document).ready(function($){
				$('.form_talks_checkbox').change(function() {		
					if ($('.form_talks_checkbox:checked').length == 0) {
						$('#talk-action-buttons').hide();
					} else {
						$('#talk-action-buttons').show();
					}
				});
			});
		</script>


		<ul class="message-list">
			{foreach from=$aTalks item=oTalk}
				{assign var="oTalkUserAuthor" value=$oTalk->getTalkUser()}
				<li {if $oTalkUserAuthor->getCommentCountNew() or !$oTalkUserAuthor->getDateLast()}class="message-unread"{/if}>
					<input type="checkbox" name="talk_select[{$oTalk->getId()}]" class="form_talks_checkbox input-checkbox" />
					
					
					<h2>
						<a href="{router page='talk'}read/{$oTalk->getId()}/" class="js-title-comment" title="{$oTalk->getTextLast()|strip_tags|truncate:100:'...'}">
							{$oTalk->getTitle()|escape:'html'}
						</a>

						<a href="#" onclick="return ls.favourite.toggle({$oTalk->getId()},this,'talk');" class="favourite icon-favourite {if $oTalk->getIsFavourite()}active{/if}"></a>
					</h2>

					
					<div class="message-info">
						<time datetime="{date_format date=$oTalk->getDate() format='c'}" class="date">{date_format date=$oTalk->getDate() format="j F Y, H:i"}</time>
						
						{if $oUserCurrent->getId()==$oTalk->getUserIdLast()}
							<i class="icon-out"></i>
						{else}
							<i class="icon-in"></i>
						{/if}

						{if $oTalk->getCountComment()}
							<strong>{$oTalk->getCountComment()}{if $oTalkUserAuthor->getCommentCountNew()} +{$oTalkUserAuthor->getCommentCountNew()}{/if}</strong>
						{/if}
					</div>
					

					{foreach from=$oTalk->getTalkUsers() item=oTalkUser name=users}
						{if $oTalkUser->getUserId() != $oUserCurrent->getId()}
							{assign var="oUser" value=$oTalkUser->getUser()}
							<a href="{$oUser->getUserWebPath()}" class="message-user {if $oTalkUser->getUserActive()!=$TALK_USER_ACTIVE}inactive{/if}">{$oUser->getLogin()}</a>
						{/if}
					{/foreach}
				</li>
			{/foreach}
		</ul>
	</form>
{else}
	<div class="notice-empty">{$aLang.talk_inbox_empty}</div>
{/if}

			
{include file='paging.tpl' aPaging=$aPaging}
{include file='footer.tpl'}