{if $aPagingCmt and $aPagingCmt.iCountPage>1}
	{if $aPagingCmt.sGetParams}
		{assign var="sGetSep" value='&'}
	{else}
		{assign var="sGetSep" value='?'}
	{/if}
	
	<div class="pagination pagination-comments">
		{if $aPagingCmt.iPrevPage}
			<a href="{$aPagingCmt.sGetParams}{$sGetSep}cmtpage={$aPagingCmt.iPrevPage}" class="pagination-arrow pagination-arrow-prev" title="{$aLang.paging_previos}"><span></span></a>
		{else}
			<div class="pagination-arrow pagination-arrow-prev inactive" title="{$aLang.paging_previos}"><span></span></div>
		{/if}

		<div class="pagination-current"><span>{$aPagingCmt.iCurrentPage}</span> {$aLang.paging_out_of} {$aPagingCmt.iCountPage}</div>

		{if $aPagingCmt.iNextPage}
			<a href="{$aPagingCmt.sGetParams}{$sGetSep}cmtpage={$aPagingCmt.iNextPage}" class="pagination-arrow pagination-arrow-next" title="{$aLang.paging_next}"><span></span></a>
		{else}
			<div class="pagination-arrow pagination-arrow-next inactive" title="{$aLang.paging_next}"><span></span></div>
		{/if}
	</div>
{/if}