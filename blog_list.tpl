{if $aBlogs}
	<table class="table table-blogs">
		<tbody>
			{foreach from=$aBlogs item=oBlog}
				{assign var="oUserOwner" value=$oBlog->getOwner()}

				<tr>
					<td class="cell-name">
						<a href="{$oBlog->getUrlFull()}">
							<img src="{$oBlog->getAvatarPath(48)}" width="48" height="48" alt="avatar" class="avatar" />
						</a>

						<h3><a href="{$oBlog->getUrlFull()}">{$oBlog->getTitle()|escape:'html'}</a></h3>
						
						<p>
							{$aLang.blogs_rating}: {$oBlog->getRating()},
							{$aLang.blogs_readers}: {$oBlog->getCountUser()}
						</p>
					</td>
					
					<td class="cell-join">
						{if $oUserCurrent}
							{if $oBlog->getType() == 'close'}
								<i title="{$aLang.blog_closed}" class="icon-blog-private"></i>
							{else}
								{if $oUserCurrent->getId() != $oBlog->getOwnerId() and $oBlog->getType() == 'open'}
									<a href="#" class="icon-blog-join {if $oBlog->getUserIsJoin()}active{/if}" onclick="ls.blog.toggleJoin(this, {$oBlog->getId()}); return false;"></a>
								{else}
									<i class="icon-blog-owner"></i>
								{/if}
							{/if}
						{/if}
					</td>
				</tr>
			{/foreach}
		</tbody>
	</table>
{else}
	{if $sBlogsEmptyList}
		<div class="notice-empty">
			{$sBlogsEmptyList}
		</div>
	{/if}
{/if}