jQuery(document).ready(function($){
	// Хук начала инициализации javascript-составляющих шаблона
	ls.hook.run('ls_template_init_start',[],window);
	
	$('html').removeClass('no-js');
	
	// Определение браузера
	if ($.browser.opera) {
		$('body').addClass('opera opera' + parseInt($.browser.version));
	}
	if ($.browser.mozilla) {
		$('body').addClass('mozilla mozilla' + parseInt($.browser.version));
	}
	if ($.browser.webkit) {
		$('body').addClass('webkit webkit' + parseInt($.browser.version));
	}
	if ($.browser.msie) {
		$('body').addClass('ie');
		if (parseInt($.browser.version) > 8) {
			$('body').addClass('ie' + parseInt($.browser.version));
		}
	}

	// Userbar
	ls.tools.showuserbar = function() {
		if ( ! $('#wrapper').hasClass('hidden')) {
			$('#userbar-trigger').toggleClass('active');

			$('#wrapper').addClass('hidden');
			$('#wrapper').css('width', $('#container').width());

			$('#userbar').addClass('show');
			$('#userbar-inner').css('min-height', $(window).height());
		}
	};


	ls.tools.hideuserbar = function() {
		if ($('#wrapper').hasClass('hidden')) {
			$('#userbar-trigger').toggleClass('active');

			$('#wrapper').removeClass('hidden');
			$('#wrapper').css('width', 'auto');

			$('#userbar').removeClass('show');
			$('#userbar-inner').css('min-height', 'auto');
		}
	};


	$('#userbar-trigger').click(function(){
		if ($('#wrapper').hasClass('hidden')) {
			ls.tools.hideuserbar();
		} else {
			ls.tools.showuserbar();
		}
	});


	if ($('#userbar').length > 0) {
		$(window).swipe( {
			swipeLeft: function(event, direction, distance, duration, fingerCount) {
				ls.tools.hideuserbar();
			},
			swipeRight: function(event, direction, distance, duration, fingerCount) {
				ls.tools.showuserbar();
			},
			excludedElements:$.fn.swipe.defaults.excludedElements+", #slider"
		});
	}


	$('.swipegallery').swipegallery();

	// Vote
	ls.vote.onVote = function(idTarget, objVote, value, type, result) {
		if (result.bStateError) {
			ls.msg.error(null, result.sMsg);
		} else {
			ls.msg.notice(null, result.sMsg);
			
			var divVoting = $('#'+this.options.prefix_area+type+'_'+idTarget);
			var divTotal = $('#'+this.options.prefix_total+type+'_'+idTarget);
			var divCount = $('#'+this.options.prefix_count+type+'_'+idTarget);

			divTotal.addClass(this.options.classes.voted);

			if (value > 0) {
				divTotal.addClass(this.options.classes.plus);
			}
			if (value < 0) {
				divTotal.addClass(this.options.classes.minus);
			}
			if (value == 0) {
				divTotal.addClass(this.options.classes.voted_zero);
			}
			
			if (divCount.length>0 && result.iCountVote) {
				divCount.text(parseInt(result.iCountVote));
			}

			result.iRating = parseFloat(result.iRating);

			divTotal.removeClass(this.options.classes.negative);
			divTotal.removeClass(this.options.classes.positive);
			divTotal.removeClass(this.options.classes.not_voted);
			divTotal.removeClass(this.options.classes.zero);

			if (result.iRating > 0) {
				divTotal.addClass(this.options.classes.positive);
				divTotal.text('+'+result.iRating);
			}else if (result.iRating < 0) {
				divTotal.addClass(this.options.classes.negative);
				divTotal.text(result.iRating);
			}else if (result.iRating == 0) {
				divTotal.addClass(this.options.classes.zero);
				divTotal.text(0);
			}

			var method='onVote'+ls.tools.ucfirst(type);
			if ($.type(this[method])=='function') {
				this[method].apply(this,[idTarget, objVote, value, type, result]);
			}

			divVoting.remove();
		}
		
		$(this).trigger('vote',[idTarget, objVote, value, type, result]);
	}


	// Add friend
	ls.user.addFriend = function(obj, idUser, sAction){
		if(sAction != 'link' && sAction != 'accept') {
			var sText = $('#add_friend_text').val();
			$('#add_friend_form').children().each(function(i, item){$(item).attr('disabled','disabled')});
		} else {
			var sText='';
		}

		if(sAction == 'accept') {
			var url = aRouter.profile+'ajaxfriendaccept/';
		} else {
			var url = aRouter.profile+'ajaxfriendadd/';
		}

		var params = {idUser: idUser, userText: sText};

		ls.hook.marker('addFriendBefore');
		ls.ajax(url, params, function(result){
			$('#add_friend_form').children().each(function(i, item){$(item).removeAttr('disabled')});
			if (!result) {
				ls.msg.error('Error','Please try again later');
			}
			if (result.bStateError) {
				ls.msg.error(null,result.sMsg);
			} else {
				ls.msg.notice(null,result.sMsg);
				$('#add_friend_form').hide();
				$('#add_friend_item').remove();
				$('#profile_actions').prepend($(result.sToggleText));
				ls.hook.run('ls_user_add_friend_after', [idUser,sAction,result], obj);
			}
		});
		return false;
	};

	ls.favourite.showEditTags = function(idTarget,type,obj) {
		var form=$('#favourite-form-tags');
		$('#favourite-form-tags-target-type').val(type);
		$('#favourite-form-tags-target-id').val(idTarget);
		var text='';
		var tags=$('.js-favourite-tags-'+$('#favourite-form-tags-target-type').val()+'-'+$('#favourite-form-tags-target-id').val());
		tags.find('.js-favourite-tag-user a').each(function(k,tag){
			if (text) {
				text=text+', '+$(tag).text();
			} else {
				text=$(tag).text();
			}
		});
		$('#favourite-form-tags-tags').val(text);
		//$(obj).parents('.js-favourite-insert-after-form').after(form);
		form.insertAfter($(obj).parent().parent());
		form.slideToggle();

		return false;
	};

	ls.favourite.hideEditTags = function() {
		$('#favourite-form-tags').slideUp();
		return false;
	};


	ls.msg = (function ($) {
		/**
		* Опции
		*/
		this.options = {
			class_notice: 'system-message-notice',
			class_error: 'system-message-error'
		};

		this.show = function(title, msg, msg_class){
			$("div[class^='system-message-']").remove();
			if (title == null) title = "";
			$('#content').prepend('<div class="' + msg_class +'"><h4>' + title + '</h4><p>' + msg + '</p></div>');
			$.scrollTo(0, 500);
		};

		/**
		* Отображение информационного сообщения
		*/
		this.notice = function(title, msg){
			this.show(title, msg, this.options.class_notice);
		};

		/**
		* Отображение сообщения об ошибке
		*/
		this.error = function(title, msg){
			this.show(title, msg, this.options.class_error);
		};

		return this;
	}).call(ls.msg || {},jQuery);



	$('.js-registration-form-show').click(function(){
		if (ls.blocks.switchTab('registration','popup-login')) {
			$('#window_login_form').jqmShow();
		} else {
			window.location=aRouter.registration;
		}
		return false;
	});

	$('.js-login-form-show').click(function(){
		if (ls.blocks.switchTab('login','popup-login')) {
			$('#window_login_form').jqmShow();
		} else {
			window.location=aRouter.login;
		}
		return false;
	});
	
	// Datepicker
	 /**
	  * TODO: навесить языки на datepicker
	  */
	$('.date-picker').datepicker({ 
		dateFormat: 'dd.mm.yy',
		dayNamesMin: ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'],
		monthNames: ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'],
		firstDay: 1
	});
	
	
	// Поиск по тегам
	$('.js-tag-search-form').submit(function(){
		window.location = aRouter['tag']+encodeURIComponent($(this).find('.js-tag-search').val())+'/';
		return false;
	});
	
	
	// Автокомплит
	ls.autocomplete.add($(".autocomplete-tags-sep"), aRouter['ajax']+'autocompleter/tag/', true);
	ls.autocomplete.add($(".autocomplete-tags"), aRouter['ajax']+'autocompleter/tag/', false);
	ls.autocomplete.add($(".autocomplete-users-sep"), aRouter['ajax']+'autocompleter/user/', true);
	ls.autocomplete.add($(".autocomplete-users"), aRouter['ajax']+'autocompleter/user/', false);

	
	// Скролл
	$(window)._scrollable();

	
	// Тул-бар топиков
	ls.toolbar.topic.init();
	// Кнопка "UP"
	ls.toolbar.up.init();

	
	// Всплывающие сообщения
	$('.js-title-comment, .js-title-topic').poshytip({
		className: 'infobox-standart',
		alignTo: 'target',
		alignX: 'left',
		alignY: 'center',
		offsetX: 5,
		liveEvents: true,
		showTimeout: 1500
	});

	$('.js-infobox-vote-topic').poshytip({
		content: function() {
			var id = $(this).attr('id').replace('vote_total_topic_','vote-info-topic-');
			return $('#'+id).html();
		},
		className: 'infobox-standart',
		alignTo: 'target',
		alignX: 'center',
		alignY: 'top',
		offsetX: 2,
		liveEvents: true,
		showTimeout: 100
	});
	
	$('.js-tip-help').poshytip({
		className: 'infobox-standart',
		alignTo: 'target',
		alignX: 'right',
		alignY: 'center',
		offsetX: 5,
		liveEvents: true,
		showTimeout: 500
	});

	// подсветка кода
	prettyPrint();
	
	// эмуляция border-sizing в IE
	var inputs = $('input.input-text, textarea');
	ls.ie.bordersizing(inputs);
	
	// эмуляция placeholder'ов в IE
	inputs.placeholder();

	// инизиализация блоков
	ls.blocks.init('stream',{group_items: true, group_min: 3});
	ls.blocks.init('blogs');
	ls.blocks.initSwitch('tags');
	ls.blocks.initSwitch('upload-img');
	ls.blocks.initSwitch('favourite-topic-tags');
	ls.blocks.initSwitch('popup-login');

	// комментарии
	ls.comments.options.folding = false;
	ls.comments.init();


	/**
	* Переключение избранного
	*/
	ls.favourite.toggle = function(idTarget, objFavourite, type) {
		if (!this.options.type[type]) { return false; }

		this.objFavourite = $(objFavourite);
		
		var params = {};
		params['type'] = !this.objFavourite.hasClass(this.options.active);
		params[this.options.type[type].targetName] = idTarget;
		
		ls.hook.marker('toggleBefore');
		ls.ajax(this.options.type[type].url, params, function(result) {
			$(this).trigger('toggle',[idTarget,objFavourite,type,params,result]);

			if (result.bStateError) {
				ls.msg.error(null, result.sMsg);
			} else {
				this.objFavourite.removeClass(this.options.active);
				if (result.bState) {
					this.objFavourite.addClass(this.options.active);
					this.showTags(type,idTarget);
				} else {
					this.hideTags(type,idTarget);
				}

				$(objFavourite).parent().toggleClass('active');
				$('#fav_count_'+type+'_'+idTarget).text((result.iCount>0) ? result.iCount : '');

				ls.hook.run('ls_favourite_toggle_after',[idTarget,objFavourite,type,params,result],this);
			}
		}.bind(this));
		return false;
	};

	ls.hook.add('ls_blog_toggle_join_after',function(idBlog,result){
		$(this).empty();
	});

	ls.hook.add('ls_wall_addreply_after',function(sText, iPid, result){
		$('#wall-reply-wrapper-'+iPid).show();
	});

	ls.favourite.hideEditTags = function() {
		$('#favourite-form-tags').hide();
		return false;
	};

	/****************
	 * TALK
	 */

	// Добавляем или удаляем друга из списка получателей
	$('#friends input:checkbox').change(function(){
		ls.talk.toggleRecipient($('#'+$(this).attr('id')+'_label').text(), $(this).attr('checked'));
	});

	// Добавляем всех друзей в список получателей
	$('#friend_check_all').click(function(){
		$('#friends input:checkbox').each(function(index, item){
			ls.talk.toggleRecipient($('#'+$(item).attr('id')+'_label').text(), true);
			$(item).attr('checked', true);
		});
		return false;
	});

	// Удаляем всех друзей из списка получателей
	$('#friend_uncheck_all').click(function(){
		$('#friends input:checkbox').each(function(index, item){
			ls.talk.toggleRecipient($('#'+$(item).attr('id')+'_label').text(), false);
			$(item).attr('checked', false);
		});
		return false;
	});

	// Удаляем пользователя из черного списка
	$("#black_list_block").delegate("a.delete", "click", function(){
		ls.talk.removeFromBlackList(this);
		return false;
	});

	// Удаляем пользователя из переписки
	$("#speaker_list_block").delegate("a.delete", "click", function(){
		ls.talk.removeFromTalk(this, $('#talk_id').val());
		return false;
	});


	// Help-tags link
	$('.js-tags-help-link').click(function(){
		var target=ls.registry.get('tags-help-target-id');
		if (!target || !$('#'+target).length) {
			return false;
		}
		target=$('#'+target);
		if ($(this).data('insert')) {
			var s=$(this).data('insert');
		} else {
			var s=$(this).text();
		}
		$.markItUp({target: target, replaceWith: s});
		return false;
	});
	
	
	// Фикс бага с z-index у встроенных видео
	$("iframe").each(function(){
		var ifr_source = $(this).attr('src');

		if(ifr_source) {
			var wmode = "wmode=opaque";
				
			if (ifr_source.indexOf('?') != -1) 
				$(this).attr('src',ifr_source+'&'+wmode);
			else 
				$(this).attr('src',ifr_source+'?'+wmode);
		}
	});


	ls.tools.slide = function(target, obj, deactivate_items) {
		if (deactivate_items) {
			obj.parent().children('li').not(obj).removeClass('active');
		}

		$('.slide').not(target).removeClass('active').hide();
		target.slideToggle(); 
		obj.toggleClass('active');
	}


	$('.nav-foldable').each(function(){
		$(this).wrap('<div class="nav-foldable-wrapper" />');

		var wrapper = $(this).parent();
		wrapper.prepend('<div class="nav-foldable-trigger inactive">' + ls.lang.get('nav_select_item') + '</div>');
		
		var trigger = wrapper.find('.nav-foldable-trigger');
		wrapper.find('ul').addClass('slide');

		if ($(this).hasClass('nav-foldable-primary')) {
			$(this).removeClass('nav-foldable-primary');
			trigger.addClass('nav-foldable-primary');
		}

		var active = wrapper.find('ul li.active');
		if (active.length > 0) {
			trigger.text(active.text()).removeClass('inactive');
		}
		
		trigger.click(function(){ 
			ls.tools.slide($(this).next('ul'), trigger);
		})
	});

	
	// Хук конца инициализации javascript-составляющих шаблона
	ls.hook.run('ls_template_init_end',[],window);
});