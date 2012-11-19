{assign var="oBlog" value=$oTopic->getBlog()}
{assign var="oUser" value=$oTopic->getUser()}
{assign var="oVote" value=$oTopic->getVote()}


<article class="topic topic-type-{$oTopic->getType()} js-topic {if !$bTopicList}topic-single{/if}">
	<header class="topic-header">
		<h1 class="topic-title word-wrap">
			{if $bTopicList}
				<a href="{$oTopic->getUrl()}">{$oTopic->getTitle()|escape:'html'}</a>
			{else}
				{$oTopic->getTitle()|escape:'html'}
			{/if}

			{if $oTopic->getPublish() == 0}   
				<i class="icon-topic-draft" title="{$aLang.topic_unpublish}"></i>
			{/if}
			
			{if $oTopic->getType() == 'link'} 
				<i class="icon-topic-link" title="{$aLang.topic_link}"></i>
			{/if}
		</h1>
		
		
		<div class="topic-info">
			<i class="icon-blog {if $oBlog->getUserIsJoin()}active{/if}"></i><a href="{$oBlog->getUrlFull()}" class="topic-blog">{$oBlog->getTitle()|escape:'html'}</a>
		</div>
	</header>