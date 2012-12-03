{include file='header.tpl' noBg=true}
{assign var="oUserOwner" value=$oBlog->getOwner()}
{assign var="oVote" value=$oBlog->getVote()}


<script type="text/javascript">
	jQuery(function($){
		ls.lang.load({lang_load name="blog_fold_info,blog_expand_info"});
	});
</script>


{if $oUserCurrent and $oUserCurrent->isAdministrator()}
	<div id="blog_delete_form" class="modal">
		<header class="modal-header">
			<h3>{$aLang.blog_admin_delete_title}</h3>
			<a href="#" class="close jqmClose"></a>
		</header>
		
		
		<form action="{router page='blog'}delete/{$oBlog->getId()}/" method="POST" class="modal-content">
			<p><label for="topic_move_to">{$aLang.blog_admin_delete_move}:</label>
			<select name="topic_move_to" id="topic_move_to" class="input-width-full">
				<option value="-1">{$aLang.blog_delete_clear}</option>
				{if $aBlogs}
					<optgroup label="{$aLang.blogs}">
						{foreach from=$aBlogs item=oBlogDelete}
							<option value="{$oBlogDelete->getId()}">{$oBlogDelete->getTitle()|escape:'html'}</option>
						{/foreach}
					</optgroup>
				{/if}
			</select></p>
			
			<input type="hidden" value="{$LIVESTREET_SECURITY_KEY}" name="security_ls_key" />
			<button type="submit" class="button button-primary">{$aLang.blog_delete}</button>
		</form>
	</div>
{/if}



<div class="blog">
	<header class="blog-header">
		<img src="{$oBlog->getAvatarPath(64)}" alt="avatar" class="avatar" />
		
		
		<h2>{$oBlog->getTitle()|escape:'html'}</h2>
		<p>
			{$aLang.blogs_rating}: <span id="vote_total_blog_alt_{$oBlog->getId()}">{$oBlog->getRating()}</span>,
			{$aLang.blogs_readers}: {$oBlog->getCountUser()}
		</p>


		<a href="#" class="icon-blog-more" id="blog-more" onclick="ls.tools.slide(jQuery('#blog-more-content'), jQuery(this)); return false;"></a>
	</header>
	
	
	<div class="blog-more-content" id="blog-more-content" style="display: none;">
		<div class="blog-content text">
			{$oBlog->getDescription()}
		</div>
		
		
		<footer class="blog-footer">
			{hook run='blog_info_begin' oBlog=$oBlog}
			<strong>{$aLang.blog_user_administrators} ({$iCountBlogAdministrators}):</strong>							
			<a href="{$oUserOwner->getUserWebPath()}" class="user">{$oUserOwner->getLogin()}</a>
			{if $aBlogAdministrators}			
				{foreach from=$aBlogAdministrators item=oBlogUser}
					{assign var="oUser" value=$oBlogUser->getUser()}  									
					<a href="{$oUser->getUserWebPath()}" class="user">{$oUser->getLogin()}</a>
				{/foreach}	
			{/if}<br />		

			
			<strong>{$aLang.blog_user_moderators} ({$iCountBlogModerators}):</strong>
			{if $aBlogModerators}						
				{foreach from=$aBlogModerators item=oBlogUser}  
					{assign var="oUser" value=$oBlogUser->getUser()}									
					<a href="{$oUser->getUserWebPath()}" class="user">{$oUser->getLogin()}</a>
				{/foreach}							
			{else}
				{$aLang.blog_user_moderators_empty}
			{/if}<br />
			
			
			<strong>{$aLang.blog_user_readers} ({$iCountBlogUsers}):</strong>
			{if $aBlogUsers}
				{foreach from=$aBlogUsers item=oBlogUser}
					{assign var="oUser" value=$oBlogUser->getUser()}
					<a href="{$oUser->getUserWebPath()}" class="user">{$oUser->getLogin()}</a>
				{/foreach}
				
				{if count($aBlogUsers) < $iCountBlogUsers}
					<br /><a href="{$oBlog->getUrlFull()}users/">{$aLang.blog_user_readers_all}</a>
				{/if}
			{else}
				{$aLang.blog_user_readers_empty}
			{/if}
			{hook run='blog_info_end' oBlog=$oBlog}
		</footer>
	</div>


	<ul class="actions clearfix">
		{if $oUserCurrent}
			{if $oBlog->getType() == 'close'}
				<li><i title="{$aLang.blog_closed}" class="icon-blog-private"></i></li>
			{else}
				{if $oUserCurrent->getId() != $oBlog->getOwnerId() and $oBlog->getType() == 'open'}
					<li><a href="#" class="icon-blog-join {if $oBlog->getUserIsJoin()}active{/if}" onclick="ls.blog.toggleJoin(this, {$oBlog->getId()}); return false;"></a></li>
				{else}
					<li><i class="icon-blog-owner"></i></li>
				{/if}
			{/if}
		{/if}

		<li><a href="{router page='rss'}blog/{$oBlog->getUrl()}/" class="icon-rss"></a></li>

		{if $oUserCurrent and ($oUserCurrent->getId()==$oBlog->getOwnerId() or $oUserCurrent->isAdministrator() or $oBlog->getUserIsAdministrator() )}
			<li><a href="{router page='blog'}edit/{$oBlog->getId()}/" title="{$aLang.blog_edit}" class="icon-edit"></a></li>
			
			{if $oUserCurrent->isAdministrator()}
				<li><a href="#" title="{$aLang.blog_delete}" id="blog_delete_show" class="icon-delete"></a></li>
			{else}
				<li><a href="{router page='blog'}delete/{$oBlog->getId()}/?security_ls_key={$LIVESTREET_SECURITY_KEY}" 
				       class="icon-delete"
				       title="{$aLang.blog_delete}"
				       onclick="return confirm('{$aLang.blog_admin_delete_confirm}');"></a></li>
			{/if}
		{/if}

		{if $oUserCurrent && $oUserCurrent->getId() != $oBlog->getOwnerId()}
			<li id="vote_total_blog_{$oBlog->getId()}" class="vote-result 
				vote-no-rating
					
				{if $oVote || ($oUserCurrent && $oUserOwner->getId() == $oUserCurrent->getId())}
					{if $oBlog->getRating() > 0}
						vote-count-positive
					{elseif $oBlog->getRating() < 0}
						vote-count-negative
					{elseif $oBlog->getRating() == 0}
						vote-count-zero
					{/if}
				{/if}

				{if $oVote} 
					voted
															
					{if $oVote->getDirection() > 0}
						voted-up
					{elseif $oVote->getDirection() < 0}
						voted-down
					{/if}
				{/if}" 

				{if $oUserCurrent && !$oVote}
					onclick="ls.tools.slide($('#vote_area_blog_{$oBlog->getId()}'), $(this));"
				{/if}

				title="{$aLang.blog_vote_count}: {$oBlog->getCountVote()}">
			</li>
		{/if}
	</ul>

	<div id="vote_area_blog_{$oBlog->getId()}" class="vote">
		<div class="vote-item vote-up" onclick="return ls.vote.vote({$oBlog->getId()},this,1,'blog');"><i></i></div>
		<div class="vote-item vote-down" onclick="return ls.vote.vote({$oBlog->getId()},this,-1,'blog');"><i></i></div>
	</div>
</div>

{hook run='blog_info' oBlog=$oBlog}





<ul class="nav-foldable">
	<li {if $sMenuSubItemSelect=='good'}class="active"{/if}><a href="{$sMenuSubBlogUrl}">{$aLang.blog_menu_collective_good}</a></li>
	<li {if $sMenuSubItemSelect=='new'}class="active"{/if}><a href="{$sMenuSubBlogUrl}newall/">{$aLang.blog_menu_collective_new}</a>{if $iCountTopicsBlogNew>0} <a href="{$sMenuSubBlogUrl}new/">+{$iCountTopicsBlogNew}</a>{/if}</li>
	<li {if $sMenuSubItemSelect=='discussed'}class="active"{/if}><a href="{$sMenuSubBlogUrl}discussed/">{$aLang.blog_menu_collective_discussed}</a></li>
	<li {if $sMenuSubItemSelect=='top'}class="active"{/if}><a href="{$sMenuSubBlogUrl}top/">{$aLang.blog_menu_collective_top}</a></li>
	{hook run='menu_blog_blog_item'}
</ul>

{if $sPeriodSelectCurrent}
	<ul class="nav-foldable">
		<li {if $sPeriodSelectCurrent=='1'}class="active"{/if}><a href="{$sPeriodSelectRoot}?period=1">{$aLang.blog_menu_top_period_24h}</a></li>
		<li {if $sPeriodSelectCurrent=='7'}class="active"{/if}><a href="{$sPeriodSelectRoot}?period=7">{$aLang.blog_menu_top_period_7d}</a></li>
		<li {if $sPeriodSelectCurrent=='30'}class="active"{/if}><a href="{$sPeriodSelectRoot}?period=30">{$aLang.blog_menu_top_period_30d}</a></li>
		<li {if $sPeriodSelectCurrent=='all'}class="active"{/if}><a href="{$sPeriodSelectRoot}?period=all">{$aLang.blog_menu_top_period_all}</a></li>
	</ul>
{/if}




{if $bCloseBlog}
	{$aLang.blog_close_show}
{else}
	{include file='topic_list.tpl'}
{/if}


{include file='footer.tpl'}