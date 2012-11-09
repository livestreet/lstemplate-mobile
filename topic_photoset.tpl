{include file='topic_part_header.tpl'}

{assign var=iMainPhotoId value=$oTopic->getPhotosetMainPhotoId()}

{assign var=aPhotos value=$oTopic->getPhotosetPhotos(0, $oConfig->get('module.topic.photoset.per_page'))} {* TODO *}
{if count($aPhotos)}   
	<div id="slider" class="swipegallery">
		<div class="sg-inner">
			<ul>                             
			{foreach from=$aPhotos item=oPhoto name=photos}
				<li {if $iMainPhotoId == $oPhoto->getId()}class="sg-item-cover"{/if}>
					<div class="sg-item-inner">
						<img src="{$oPhoto->getWebPath(1000)}" alt="{$oPhoto->getDescription()}" />
						{if $oPhoto->getDescription()}<div class="sg-item-desc">{$oPhoto->getDescription()}</div>{/if}
					</div>
				</li>
			{/foreach}
			</ul>
		</div>
		
		<div class="sg-nav">
			<i class="icon-prev sg-prev"></i>
			<i class="icon-next sg-next"></i>
			
			<span class="sg-counter"><span class="sg-pos">1</span> / {$oTopic->getPhotosetCount()}</span>
		</div>
	</div>
{/if}

{*{assign var=oMainPhoto value=$oTopic->getPhotosetMainPhoto()}
{if $oMainPhoto}
<div class="topic-photo-preview" id="photoset-main-preview-{$oTopic->getId()}" onclick="window.location='{$oTopic->getUrl()}#photoset'">
	<div class="topic-photo-count" id="photoset-photo-count-{$oTopic->getId()}">{$oTopic->getPhotosetCount()} {$aLang.topic_photoset_photos}</div>
	
	{if $oMainPhoto->getDescription()}
		<div class="topic-photo-desc" id="photoset-photo-desc-{$oTopic->getId()}">{$oMainPhoto->getDescription()}</div>
	{/if}
	
	<img src="{$oMainPhoto->getWebPath(500)}" alt="image" id="photoset-main-image-{$oTopic->getId()}" />
</div>
{/if}*}


{assign var=iPhotosCount value=$oTopic->getPhotosetCount()}
<div class="topic-content text">
	{hook run='topic_content_begin' topic=$oTopic bTopicList=$bTopicList}
	
	{if $bTopicList}
		{$oTopic->getTextShort()}
		{if $oTopic->getTextShort()!=$oTopic->getText()}
			<br />
			<a href="{$oTopic->getUrl()}#cut" title="{$aLang.topic_read_more}">
				{if $oTopic->getCutText()}
					{$oTopic->getCutText()}
				{else}
					{$aLang.topic_photoset_show_all|ls_lang:"COUNT%%`$iPhotosCount`"} &rarr;
				{/if}                           
			</a>
		{/if}
	{else}
		{$oTopic->getText()}
	{/if}
	
	{hook run='topic_content_end' topic=$oTopic bTopicList=$bTopicList}
</div> 


{if !$bTopicList}
	<script type="text/javascript" src="{cfg name='path.root.engine_lib'}/external/prettyPhoto/js/prettyPhoto.js"></script>	
	<link rel='stylesheet' type='text/css' href="{cfg name='path.root.engine_lib'}/external/prettyPhoto/css/prettyPhoto.css" />
	<script type="text/javascript">
		jQuery(document).ready(function($) {	
			$('.photoset-image').prettyPhoto({
				social_tools:'',
				show_title: false,
				slideshow:false,
				deeplinking: false
			});
		});
	</script>
{/if}

 
{include file='topic_part_footer.tpl'}