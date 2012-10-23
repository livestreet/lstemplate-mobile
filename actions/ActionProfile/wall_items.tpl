{foreach from=$aWall item=oWall}
	{assign var="oWallUser" value=$oWall->getUser()}
	{assign var="aReplyWall" value=$oWall->getLastReplyWall()}

	<div id="wall-item-{$oWall->getId()}" class="js-wall-item wall-comment-wrapper">
		<div class="wall-comment">
			<a href="{$oWallUser->getUserWebPath()}"><img src="{$oWallUser->getProfileAvatarPath(48)}" alt="avatar" class="comment-avatar" /></a>
			
			<ul class="comment-info clearfix">
				<li class="comment-author"><a href="{$oWallUser->getUserWebPath()}">{$oWallUser->getLogin()}</a></li>
				<li class="comment-date">
					<time datetime="{date_format date=$oWall->getDateAdd() format='c'}">{date_format date=$oWall->getDateAdd() hours_back="12" minutes_back="60" now="60" day="day H:i" format="j F Y, H:i"}</time>

					{if $oWall->isAllowDelete()}
						&nbsp;&nbsp;&nbsp;<a href="#" onclick="return ls.wall.remove({$oWall->getId()});" class="link-dotted">{$aLang.wall_action_delete}</a>
					{/if}
				</li>
			</ul>

			<div class="comment-content text">
				{$oWall->getText()}
			</div>
		
			{if $oUserCurrent and !$aReplyWall}
				<div class="wall-reply-link">
					<a href="#" onclick="return ls.wall.toggleReply({$oWall->getId()});">{$aLang.wall_action_reply}</a>
				</div>
			{/if}
		</div>
		
		
		<div id="wall-reply-wrapper-{$oWall->getId()}" class="comment-wrapper-replies" {if !$aReplyWall}style="display: none"{/if}>
			<div id="wall-reply-container-{$oWall->getId()}">
				{if count($aReplyWall) < $oWall->getCountReply()}
					<a href="#" onclick="return ls.wall.loadReplyNext({$oWall->getId()});" id="wall-reply-button-next-{$oWall->getId()}" class="wall-more wall-more-reply">
						<span class="wall-more-inner">{$aLang.wall_load_reply_more} <span id="wall-reply-count-next-{$oWall->getId()}">{$oWall->getCountReply()}</span> {$oWall->getCountReply()|declension:$aLang.comment_declension:'russian'}</span>
					</a>
				{/if}
				
				{if $aReplyWall}
					{include file='actions/ActionProfile/wall_items_reply.tpl'}
				{/if}
			</div>

			{if $oUserCurrent}
				<div class="wall-reply-link">
					<a href="#" onclick="return ls.wall.toggleReply({$oWall->getId()});">{$aLang.wall_action_reply}</a>
				</div>
			{/if}
		</div>


		{if $oUserCurrent}
			<form class="wall-submit wall-submit-reply">
				<textarea rows="4" id="wall-reply-text-{$oWall->getId()}" class="input-text input-width-full js-wall-reply-text" placeholder="{$aLang.wall_reply_placeholder}" onclick="return ls.wall.expandReply({$oWall->getId()});"></textarea>
				<button type="button" onclick="ls.wall.addReply(jQuery('#wall-reply-text-{$oWall->getId()}').val(), {$oWall->getId()});" class="button button-primary js-button-wall-submit">{$aLang.wall_reply_submit}</button>
			</form>
		{/if}
	</div>
{/foreach}