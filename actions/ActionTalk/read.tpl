{include file='header.tpl' noBg=true}


<div class="wrapper mb-10">
	{include file='actions/ActionProfile/profile_top.tpl'}
	{include file='menu.talk.tpl'}
</div>


{assign var="oUser" value=$oTalk->getUser()}


<article class="topic topic-type-talk topic-single">
	<header class="topic-header">
		<h1 class="topic-title">{$oTalk->getTitle()|escape:'html'}</h1>
	</header>
	
	
	<div class="topic-content text">
		{$oTalk->getText()}
	</div>
	
	
	<footer class="topic-footer">
		<ul class="topic-info-extra clearfix">
			<li class="topic-info-author">
				<p>
					{foreach from=$oTalk->getTalkUsers() item=oTalkUser name=users}
						{assign var="oUserRecipient" value=$oTalkUser->getUser()}
						<a class="message-user {if $oTalkUser->getUserActive() != $TALK_USER_ACTIVE}inactive{/if}" href="{$oUserRecipient->getUserWebPath()}">{$oUserRecipient->getLogin()}</a>{if !$smarty.foreach.users.last}, 
						{/if}
					{/foreach}
				</p>

				<time datetime="{date_format date=$oTalk->getDateAdd() format='c'}" title="{date_format date=$oTalk->getDateAdd() format='j F Y, H:i'}">
					{date_format date=$oTalk->getDateAdd() format="j F Y, H:i"}
				</time>
			</li>

			<li class="topic-info-extra-trigger" onclick="ls.tools.slide($('#talk-extra-target-{$oTalk->getId()}'), $(this)); return false;"><i class="icon-topic-menu"></i></li>
		</ul>


		<ul class="slide slide-topic-info-extra" id="talk-extra-target-{$oTalk->getId()}">
			{if $oTalk->getUserId()==$oUserCurrent->getId() or $oUserCurrent->isAdministrator()}
				<li><a href="#" class="link-dotted" onclick="ls.tools.slide($('#talk_recipients'), $(this)); return false;">{$aLang.talk_speaker_edit}</a></li>
			{/if}
			<li><a href="{router page='talk'}delete/{$oTalk->getId()}/?security_ls_key={$LIVESTREET_SECURITY_KEY}" onclick="return confirm('{$aLang.talk_inbox_delete_confirm}');" class="delete">{$aLang.delete}</a></li>
			{hook run='talk_read_info_item' talk=$oTalk}
		</ul>
	
	
		{include file='actions/ActionTalk/speakers.tpl'}
	</footer>
</article>

{assign var="oTalkUser" value=$oTalk->getTalkUser()}

{if !$bNoComments}
{include
	file='comment_tree.tpl'
	iTargetId=$oTalk->getId()
	sTargetType='talk'
	iCountComment=$oTalk->getCountComment()
	sDateReadLast=$oTalkUser->getDateLast()
	sNoticeCommentAdd=$aLang.topic_comment_add
	bNoCommentFavourites=true}
{/if}
			
			
{include file='footer.tpl'}