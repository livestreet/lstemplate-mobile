<ul class="nav-foldable">
	<li {if $sMenuItemSelect=='topic'}class="active"{/if}><a href="{router page='topic'}add/">{$aLang.block_create}  {$aLang.topic_menu_add}</a></li>
	<li {if $sMenuItemSelect=='blog'}class="active"{/if}><a href="{router page='blog'}add/">{$aLang.block_create} {$aLang.blog_menu_create}</a></li>
	{hook run='menu_create_item' sMenuItemSelect=$sMenuItemSelect}
</ul>


{if $sMenuItemSelect=='topic'}
	<ul class="nav-foldable">
		<li {if $sMenuSubItemSelect=='topic'}class="active"{/if}><a href="{router page='topic'}add/">{$aLang.topic_menu_add_topic}</a></li>
		<li {if $sMenuSubItemSelect=='question'}class="active"{/if}><a href="{router page='question'}add/">{$aLang.topic_menu_add_question}</a></li>
		<li {if $sMenuSubItemSelect=='link'}class="active"{/if}><a href="{router page='link'}add/">{$aLang.topic_menu_add_link}</a></li>
		<li {if $sMenuSubItemSelect=='photoset'}class="active"{/if}><a href="{router page='photoset'}add/">{$aLang.topic_menu_add_photoset}</a></li>
		{hook run='menu_create_topic_item'}
	</ul>
{/if}


{hook run='menu_create' sMenuItemSelect=$sMenuItemSelect sMenuSubItemSelect=$sMenuSubItemSelect}