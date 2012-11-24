	{assign var="oBlog" value=$oTopic->getBlog()}
	{assign var="oUser" value=$oTopic->getUser()}
	{assign var="oVote" value=$oTopic->getVote()}
	{assign var="oFavourite" value=$oTopic->getFavourite()}

	{if $oVote || ($oUserCurrent && $oTopic->getUserId() == $oUserCurrent->getId()) || strtotime($oTopic->getDateAdd()) < $smarty.now-$oConfig->GetValue('acl.vote.topic.limit_time')}
		{assign var="bVoteInfoShow" value=true}
	{/if}

	<footer class="topic-footer">
		{if $oTopic->getType() == 'link'}
			<div class="topic-url">
				<a href="{router page='link'}go/{$oTopic->getId()}/" title="{$aLang.topic_link_count_jump}: {$oTopic->getLinkCountJump()}">{$oTopic->getLinkUrl()}</a>
			</div>
		{/if}
	
		{if !$bTopicList}
			<ul class="topic-tags js-favourite-insert-after-form js-favourite-tags-topic-{$oTopic->getId()}">
				<li><strong>{$aLang.topic_tags}:</strong></li>
				
				{strip}
					{if $oTopic->getTagsArray()}
						{foreach from=$oTopic->getTagsArray() item=sTag name=tags_list}
							<li>{if !$smarty.foreach.tags_list.first}, {/if}<a rel="tag" href="{router page='tag'}{$sTag|escape:'url'}/">{$sTag|escape:'html'}</a></li>
						{/foreach}
					{else}
						<li>{$aLang.topic_tags_empty}</li>
					{/if}
					
					{if $oUserCurrent}
						{if $oFavourite}
							{foreach from=$oFavourite->getTagsArray() item=sTag name=tags_list_user}
								<li class="topic-tags-user js-favourite-tag-user">, <a rel="tag" href="{$oUserCurrent->getUserWebPath()}favourites/topics/tag/{$sTag|escape:'url'}/">{$sTag|escape:'html'}</a></li>
							{/foreach}
						{/if}
						
						<li class="topic-tags-edit js-favourite-tag-edit" {if !$oFavourite}style="display:none;"{/if}>
							<a href="#" onclick="return ls.favourite.showEditTags({$oTopic->getId()},'topic',this);" class="link-dotted">{$aLang.favourite_form_tags_button_show}</a>
						</li>
					{/if}
				{/strip}
			</ul>
		{/if}


		<ul class="topic-info clearfix">
			{if !$bTopicList}
				<li class="topic-info-vote">
					<div class="vote-result
								{if $oVote || ($oUserCurrent && $oTopic->getUserId() == $oUserCurrent->getId()) || strtotime($oTopic->getDateAdd()) < $smarty.now-$oConfig->GetValue('acl.vote.topic.limit_time')}
									{if $oTopic->getRating() > 0}
										vote-count-positive
									{elseif $oTopic->getRating() < 0}
										vote-count-negative
									{elseif $oTopic->getRating() == 0}
										vote-count-zero
									{/if}
								{/if}
								
								{if $oVote} 
									voted
																			
									{if $oVote->getDirection() > 0}
										voted-up
									{elseif $oVote->getDirection() < 0}
										voted-down
									{elseif $oVote->getDirection() == 0}
										voted-zero
									{/if}
								{/if}
				
								{if (strtotime($oTopic->getDateAdd()) < $smarty.now-$oConfig->GetValue('acl.vote.topic.limit_time') && !$oVote) || ($oUserCurrent && $oTopic->getUserId() == $oUserCurrent->getId())}
									vote-nobuttons
								{/if}" 
				
						id="vote_total_topic_{$oTopic->getId()}" 
				
						{if !$oVote && !$bVoteInfoShow}
							onclick="ls.tools.slide($('#vote_area_topic_{$oTopic->getId()}'), $(this));"
						{/if}
				
						{if false}
							onclick="ls.tools.slide($('#vote-info-topic-{$oTopic->getId()}'), $(this));"
						{/if}>
						{if $bVoteInfoShow}
							{if $oTopic->getRating() > 0}+{/if}{$oTopic->getRating()}
						{/if}
					</div>
				</li>
			{/if}
			
			<li class="topic-info-views">
				<i class="icon-views"></i> {$oTopic->getCountRead()}
			</li>

			<li class="topic-info-favourite {if $oUserCurrent && $oTopic->getIsFavourite()}active{/if}" onclick="return ls.favourite.toggle({$oTopic->getId()},'#fav_topic_{$oTopic->getId()}','topic');">
				<i id="fav_topic_{$oTopic->getId()}" class="favourite icon-favourite {if $oUserCurrent && $oTopic->getIsFavourite()}active{/if}"></i>
				<span class="favourite-count" id="fav_count_topic_{$oTopic->getId()}">{if $oTopic->getCountFavourite() > 0}{$oTopic->getCountFavourite()}{/if}</span>
			</li>
			
			{if $bTopicList}
				<li class="topic-info-comments">
					<a href="{$oTopic->getUrl()}#comments" title="{$aLang.topic_comment_read}">
						<i class="icon-comments {if $oTopic->getCountComment() != 0 && ($oTopic->getCountComment() == $oTopic->getCountCommentNew() || $oTopic->getCountCommentNew())}active{/if}"></i>
						<span class="comments-count">
							{$oTopic->getCountComment()}
							{if $oTopic->getCountCommentNew()}<span class="comments-new">+{$oTopic->getCountCommentNew()}</span>{/if}
						</span>
					</a> 
				</li>
			{/if}

			<li class="topic-info-share" onclick="ls.tools.slide($('#topic_share_{$oTopic->getId()}'), $(this));">
				<i class="icon-share"></i>
			</li>
		</ul>

		{if $bVoteInfoShow}
			<div id="vote-info-topic-{$oTopic->getId()}" class="slide slide-bg-grey">
				+ {$oTopic->getCountVoteUp()}<br/>
				- {$oTopic->getCountVoteDown()}<br/>
				&nbsp; {$oTopic->getCountVoteAbstain()}<br/>
				{hook run='topic_show_vote_stats' topic=$oTopic}
			</div>
		{/if}
		
		<div class="slide slide-topic-info-extra" id="topic_share_{$oTopic->getId()}">
			{hookb run="topic_share" topic=$oTopic bTopicList=$bTopicList}
				<div class="yashare-auto-init" data-yashareTitle="{$oTopic->getTitle()|escape:'html'}" data-yashareLink="{$oTopic->getUrl()}" data-yashareL10n="ru" data-yashareType="button" data-yashareQuickServices="yaru,vkontakte,facebook,twitter,odnoklassniki,moimir,lj,gplus"></div>
			{/hookb}
		</div>


		<div id="vote_area_topic_{$oTopic->getId()}" class="vote">
			<div class="vote-item vote-up" onclick="return ls.vote.vote({$oTopic->getId()},this,1,'topic');"><i></i></div>
			{if !$bVoteInfoShow}
				<div class="vote-item vote-zero" title="{$aLang.topic_vote_count}: {$oTopic->getCountVote()}" onclick="return ls.vote.vote({$oTopic->getId()},this,0,'topic');">
					<i></i> Воздержаться
				</div>
			{/if}
			<div class="vote-item vote-down" onclick="return ls.vote.vote({$oTopic->getId()},this,-1,'topic');"><i></i></div>
		</div>



		<ul class="topic-info-extra clearfix">
			<li class="topic-info-author">
				<a href="{$oUser->getUserWebPath()}"><img src="{$oUser->getProfileAvatarPath(48)}" alt="avatar" /></a>
				<p><a rel="author" href="{$oUser->getUserWebPath()}">{$oUser->getLogin()}</a></p>
				<time datetime="{date_format date=$oTopic->getDateAdd() format='c'}" title="{date_format date=$oTopic->getDateAdd() format='j F Y, H:i'}">
					{date_format date=$oTopic->getDateAdd() format="j F Y, H:i"}
				</time>
			</li>

			{if $oUserCurrent}
				<li class="topic-info-extra-trigger" onclick="ls.tools.slide($('#topic-extra-target-{$oTopic->getId()}'), $(this));">
					<i class="icon-topic-menu"></i>
				</li>
			{/if}
			
			{hook run='topic_show_info' topic=$oTopic}
		</ul>


		<ul class="slide slide-topic-info-extra" id="topic-extra-target-{$oTopic->getId()}">
			{if $oUserCurrent}
				<li><a href="{router page='talk'}add/?talk_users={$oUser->getLogin()}">{$aLang.send_message_to_author}</a></li>
			{/if}

			{if $oUserCurrent and ($oUserCurrent->getId()==$oTopic->getUserId() or $oUserCurrent->isAdministrator() or $oBlog->getUserIsAdministrator() or $oBlog->getUserIsModerator() or $oBlog->getOwnerId()==$oUserCurrent->getId())}
				<li><a href="{cfg name='path.root.web'}/{$oTopic->getType()}/edit/{$oTopic->getId()}/" title="{$aLang.topic_edit}" class="actions-edit">{$aLang.topic_edit}</a></li>
			{/if}
			
			{if $oUserCurrent and ($oUserCurrent->isAdministrator() or $oBlog->getUserIsAdministrator() or $oBlog->getOwnerId()==$oUserCurrent->getId())}
				<li><a href="{router page='topic'}delete/{$oTopic->getId()}/?security_ls_key={$LIVESTREET_SECURITY_KEY}" title="{$aLang.topic_delete}" onclick="return confirm('{$aLang.topic_delete_confirm}');" class="actions-delete">{$aLang.topic_delete}</a></li>
			{/if}
		</ul>

		
		{if !$bTopicList}
			{hook run='topic_show_end' topic=$oTopic}
		{/if}
	</footer>
</article> <!-- /.topic -->