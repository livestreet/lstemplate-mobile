{if $oTopicUserProfileLast}
<tr>
    <td colspan="2" class="cell-latest-post">
		{$aLang.profile_latest_post} —
        <time datetime="{date_format date=$oTopicUserProfileLast->getDateAdd() format='c'}" title="{date_format date=$oTopicUserProfileLast->getDateAdd() format='j F Y, H:i'}">
			{date_format date=$oTopicUserProfileLast->getDateAdd() hours_back="12" minutes_back="60" now="60" day="day H:i" format="j F Y, H:i"}
        </time><br />
        <a href="{$oTopicUserProfileLast->getUrl()}">{$oTopicUserProfileLast->getTitle()|escape:'html'}</a>
    </td>
</tr>
{/if}