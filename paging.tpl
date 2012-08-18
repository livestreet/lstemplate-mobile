{if $aPaging and $aPaging.iCountPage>1} 
	<div class="pagination">
		<div class="dotted-line"></div>

		{if $aPaging.iPrevPage}
			<a href="{$aPaging.sBaseUrl}/page{$aPaging.iPrevPage}/{$aPaging.sGetParams}" class="pagination-arrow pagination-arrow-prev js-paging-prev-page" title="{$aLang.paging_previos}"><span></span></a>
		{else}
			<div class="pagination-arrow pagination-arrow-prev inactive" title="{$aLang.paging_previos}"><span></span></div>
		{/if}
		
		<div class="pagination-current"><span>{$aPaging.iCurrentPage}</span> / 100</div>
		
		{if $aPaging.iNextPage}
			<a href="{$aPaging.sBaseUrl}/page{$aPaging.iNextPage}/{$aPaging.sGetParams}" class="pagination-arrow pagination-arrow-next js-paging-next-page" title="{$aLang.paging_next}"><span></span></a>
		{else}
			<div class="pagination-arrow pagination-arrow-next inactive" title="{$aLang.paging_next}"><span></span></div>
		{/if}			
	</div>
{/if}