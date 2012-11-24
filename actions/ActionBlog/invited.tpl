<button class="button" onclick="ls.tools.slide(jQuery('#blog-invite-users'), jQuery(this));">{$aLang.blog_admin_user_add_header}</button>

<section class="slide slide-bg-grey mt-10" id="blog-invite-users">
	<form onsubmit="return ls.blog.addInvite({$oBlogEdit->getId()});">
		<p class="mb-10">
			<label for="blog_admin_user_add">{$aLang.blog_admin_user_add_label}:</label>
			<input type="text" id="blog_admin_user_add" name="add" class="input-text input-width-full autocomplete-users-sep" />
		</p>
		
		<button class="button button-primary" onclick="return ls.blog.addInvite({$oBlogEdit->getId()});">{$aLang.blog_admin_user_add}</button>
	</form>

	<br />
	<h3>{$aLang.blog_admin_user_invited}:</h3>

	<div id="invited_list_block">
		{if $aBlogUsersInvited}
			<ul id="invited_list">
				{foreach from=$aBlogUsersInvited item=oBlogUser}
					{assign var='oUser' value=$oBlogUser->getUser()}
					
					<li id="blog-invite-remove-item-{$oBlogEdit->getId()}-{$oUser->getId()}">
						<a href="{$oUser->getUserWebPath()}" class="user">{$oUser->getLogin()}</a> - 
						<a href="#" class="link-dotted" onclick="return ls.blog.repeatInvite({$oUser->getId()}, {$oBlogEdit->getId()});">{$aLang.blog_user_invite_readd}</a>&nbsp;&nbsp;&nbsp;
						<a href="#" class="link-dotted" onclick="return ls.blog.removeInvite({$oUser->getId()}, {$oBlogEdit->getId()});">{$aLang.blog_user_invite_remove}</a>
					</li>						
				{/foreach}
			</ul>
		{/if}

		<span id="blog-invite-empty" class="notice-empty" {if $aBlogUsersInvited}style="display: none"{/if}>{$aLang.blog_admin_user_add_empty}</span>
	</div>
</section>