<div class="comments comment-list">
	{foreach from=$aComments item=oComment}
		{assign var="oUser" value=$oComment->getUser()}
		{assign var="oTopic" value=$oComment->getTarget()}
		{assign var="oBlog" value=$oTopic->getBlog()}
		
		
		<div class="comment-path">
			<a href="{$oBlog->getUrlFull()}" class="blog-name">{$oBlog->getTitle()|escape:'html'}</a> &rarr;
			<a href="{$oTopic->getUrl()}">{$oTopic->getTitle()|escape:'html'}</a>
			<a href="{$oTopic->getUrl()}#comments">({$oTopic->getCountComment()})</a>
		</div>	
		<section id="comment_id_{$oComment->getId()}" class="comment
																{if $oComment->isBad()}
																	comment-bad
																{/if}

																{if $oComment->getDelete()}
																	comment-deleted
																{elseif $oUserCurrent and $oComment->getUserId() == $oUserCurrent->getId()} 
																	comment-self
																{/if}">
			{if !$oComment->getDelete() or $bOneComment or ($oUserCurrent and $oUserCurrent->isAdministrator())}
				<a name="comment{$oComment->getId()}"></a>
				
				{if $oComment->getTargetType() != 'talk'}	
					<span class="vote-result-comment
						{if $oComment->getRating() > 0}
							vote-count-positive
						{elseif $oComment->getRating() < 0}
							vote-count-negative
						{elseif $oComment->getRating() == 0}
							vote-count-zero
						{/if}

						{if $oVote} 
							voted
																	
							{if $oVote->getDirection() > 0}
								voted-up
							{elseif $oVote->getDirection() < 0}
								voted-down
							{/if}
						{/if}}" 

						id="vote_total_comment_{$oComment->getId()}">
						{if $oComment->getRating() > 0}+{/if}{$oComment->getRating()}
					</span>
				{/if}

				<a href="{$oUser->getUserWebPath()}"><img src="{$oUser->getProfileAvatarPath(48)}" alt="avatar" class="comment-avatar" /></a>
				
				
				<ul class="comment-info {if $iAuthorId == $oUser->getId()}comment-topic-author{/if}">
					<li class="comment-author">
						<a href="{$oUser->getUserWebPath()}">{$oUser->getLogin()}</a>
					</li>
					<li class="comment-date">
						<a href="{if $oConfig->GetValue('module.comment.nested_per_page')}{router page='comments'}{else}#comment{/if}{$oComment->getId()}" title="{$aLang.comment_url_notice}">
							<time datetime="{date_format date=$oComment->getDate() format='c'}">{date_format date=$oComment->getDate() hours_back="12" minutes_back="60" now="60" day="day H:i" format="j F Y, H:i"}</time>
						</a>
						
						<div class="comment-new-mark"></div>
					</li>
				</ul>
				
				
				<div id="comment_content_id_{$oComment->getId()}" class="comment-content text">
					{$oComment->getText()}
				</div>
					
					
				{if $oUserCurrent}
					<ul class="comment-actions clearfix">
						{if $oUserCurrent and !$bNoCommentFavourites}
							<li class="comment-favourite" onclick="return ls.favourite.toggle({$oComment->getId()},'#fav_comment_{$oComment->getId()}','comment');">
								<div id="fav_comment_{$oComment->getId()}" class="favourite icon-favourite {if $oComment->getIsFavourite()}active{/if}"></div>
								<span class="favourite-count" id="fav_count_comment_{$oComment->getId()}">{if $oComment->getCountFavourite() > 0}{$oComment->getCountFavourite()}{/if}</span>
							</li>
						{/if}
						
						{hook run='comment_action' comment=$oComment}
					</ul>
				{/if}


					
				{if $oComment->getTargetType() != 'talk'}						
					<div id="vote_area_comment_{$oComment->getId()}" class="vote">
						<div class="vote-item vote-down" onclick="return ls.vote.vote({$oComment->getId()},this,-1,'comment');"><i></i></div>
						<div class="vote-item vote-up" onclick="return ls.vote.vote({$oComment->getId()},this,1,'comment');"><i></i></div>
					</div>
				{/if}
			{else}				
				{$aLang.comment_was_delete}
			{/if}	
		</section>
	{/foreach}	
</div>


{include file='paging.tpl' aPaging=$aPaging}