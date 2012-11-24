<ul class="slide slide-write" id="write">
	{if $iUserCurrentCountTopicDraft}
		<li class="write-item-type-draft">
			<i class="icon-submit-draft"></i>
			<a href="{router page='topic'}saved/" class="write-item-link">{$aLang.topic_menu_saved} ({$iUserCurrentCountTopicDraft})</a>
		</li>
	{/if}
	<li class="write-item-type-topic">
		<i class="icon-submit-topic"></i>
		<a href="{router page='topic'}add" class="write-item-link">{$aLang.block_create_topic_topic}</a>
	</li>
	<li class="write-item-type-blog">
		<i class="icon-submit-blog"></i>
		<a href="{router page='blog'}add" class="write-item-link">{$aLang.block_create_blog}</a>
	</li>
	<li class="write-item-type-message">
		<i class="icon-submit-message"></i>
		<a href="{router page='talk'}add" class="write-item-link">{$aLang.block_create_talk}</a>
	</li>
	{hook run='write_item' isPopup=true}
</ul>
	