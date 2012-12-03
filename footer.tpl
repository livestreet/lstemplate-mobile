			{hook run='content_end'}
		</div> <!-- /content -->

		
		<footer id="footer">
			{if $oUserCurrent}
				<ul class="footer-profile-links clearfix">
					<li><a href="{$oUserCurrent->getUserWebPath()}"><i class="icon-profile-profile"></i></a></li>
					<li><a href="{router page='talk'}"><i class="icon-profile-messages"></i></a></li>
					<li><a href="{$oUserCurrent->getUserWebPath()}created/topics/"><i class="icon-profile-submited"></i></a></li>
					<li><a href="{$oUserCurrent->getUserWebPath()}favourites/topics/"><i class="icon-profile-favourites"></i></a></li>
					<li><a href="{$oUserCurrent->getUserWebPath()}friends/"><i class="icon-profile-friends"></i></a></li>
					<li><a href="{router page='stream'}"><i class="icon-profile-activity"></i></a></li>
					<li><a href="{router page='settings'}"><i class="icon-profile-settings"></i></a></li>
				</ul>
			{/if}
			
			<div class="footer-inner">
				<ul class="footer-links clearfix">
					<li><a href="{cfg name='path.root.web'}">{$aLang.desktop_version}</a></li>
					<li><a href="{$aHtmlRssAlternate.url}">RSS</a></li>
				</ul>
				
				<div class="copyright">
					&copy; {cfg name='view.name'}
					
					<br />
					<br />
				
					{hook run='copyright'}<br />
					Дизайн от <a href="http://designmobile.ru">DesignMobile</a>
					
					{if $oUserCurrent && $oUserCurrent->isAdministrator()}
						<br /><a href="{router page='admin'}">{$aLang.admin_header}</a>
					{/if}
				</div>
			</div>
			
			{hook run='footer_end'}
		</footer>
	</div> <!-- /wrapper -->
</div> <!-- /container -->

{hook run='body_end'}

</body>
</html>