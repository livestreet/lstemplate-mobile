{include file='header.tpl' noBg=true}

<div class="wrapper mb-10">
	<form action="" method="GET" class="js-tag-search-form search-tags no-mg">
		<input type="text" name="tag" placeholder="{$aLang.block_tags_search}" value="{$sTag|escape:'html'}" class="input-text input-width-full autocomplete-tags js-tag-search" />
	</form>
</div>

{include file='topic_list.tpl'}

{include file='footer.tpl'}