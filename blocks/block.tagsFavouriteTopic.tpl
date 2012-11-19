<button class="button" onclick="ls.tools.slide(jQuery('#block_favourite_topic_content'), jQuery(this));">{$aLang.topic_favourite_tags_block}</button>

<section class="slide slide-bg-grey mt-10" id="block_favourite_topic_content">
	<ul class="nav nav-tabs">
		<li class="active js-block-favourite-topic-tags-item" data-type="all"><a href="#">{$aLang.topic_favourite_tags_block_all}</a></li>
		<li class="js-block-favourite-topic-tags-item" data-type="user"><a href="#">{$aLang.topic_favourite_tags_block_user}</a></li>

		{hook run='block_favourite_topic_tags_nav_item'}
	</ul>
	
	
	<div class="js-block-favourite-topic-tags-content" data-type="all">
		{if $aFavouriteTopicTags}
			<ul class="tag-cloud word-wrap">
				{foreach from=$aFavouriteTopicTags item=oTag}
					<li><a class="tag-size-{$oTag->getSize()} {if $sFavouriteTag==$oTag->getText()}tag-current{/if}" title="{$oTag->getCount()}" href="{$oFavouriteUser->getUserWebPath()}favourites/topics/tag/{$oTag->getText()|escape:'url'}/">{$oTag->getText()}</a></li>
				{/foreach}
			</ul>
		{else}
			<div class="notice-empty">{$aLang.block_tags_empty}</div>
		{/if}
	</div>
	
	<div class="js-block-favourite-topic-tags-content" data-type="user" style="display: none;">
		{if $aFavouriteTopicUserTags}
			<ul class="tag-cloud word-wrap">
				{foreach from=$aFavouriteTopicUserTags item=oTag}
					<li><a class="tag-size-{$oTag->getSize()}" title="{$oTag->getCount()}" href="{$oFavouriteUser->getUserWebPath()}favourites/topics/tag/{$oTag->getText()|escape:'url'}/">{$oTag->getText()}</a></li>
				{/foreach}
			</ul>
		{else}
			<div class="notice-empty">{$aLang.block_tags_empty}</div>
		{/if}
	</div>
</section>