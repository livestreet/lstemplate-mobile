{include file='header.tpl' noBg=true}


<div class="wrapper mb-10">
	{include file='actions/ActionProfile/profile_top.tpl'}
	{include file='menu.profile_favourite.tpl'}

	{if $oUserCurrent and $oUserCurrent->getId()==$oUserProfile->getId()}
		{$aBlockParams.user=$oUserProfile}
		{insert name="block" block=tagsFavouriteTopic params=$aBlock.params}
	{/if}
</div>

{include file='topic_list.tpl'}



{include file='footer.tpl'}