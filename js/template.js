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

	$(".text").fitVids({customSelector: "iframe"});

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

	ls.tools.bindswipe = function() {
		$(document).swipe( {
			swipeLeft: function(event, direction, distance, duration, fingerCount) {
				ls.tools.hideuserbar();
			},
			swipeRight: function(event, direction, distance, duration, fingerCount) {
				ls.tools.showuserbar();
			},
			click: function(event, target) {
				return false;
			},
			excludedElements: $.fn.swipe.defaults.excludedElements+", #slider, li, i, .nav-foldable-trigger, #userbar-trigger",
			fallbackToMouseEvents: true,
			threshold: $(window).width() * .4
		});
	}

	if ($('#userbar').length > 0) {
		ls.tools.bindswipe();
	}

	$(window).resize(function () {
		if ($('#userbar').length > 0) {
			ls.tools.bindswipe();
		}
	});

	$(window).swipe( {
		swipeStatus:function(event, phase, direction, distance, fingerCount){
			if ($('#notifier').length > 0) $('#notifier').empty();
		},
		excludedElements: $.fn.swipe.defaults.excludedElements+", #slider, li, i, .nav-foldable-trigger, #userbar-trigger",
		triggerOnTouchEnd: false,
		allowPageScroll: 'vertical',
		fallbackToMouseEvents: false,
	});

	$('.swipegallery').swipegallery();

	ls.photoset.showForm = function() {
		$('#topic-photo-upload-input').appendTo('#photoset-wrapper');
		$('#topic-photo-upload-input').show();
	};

	ls.photoset.closeForm = function() {
		$('#topic-photo-upload-input').appendTo('#photoset-upload-form');
		$('#photoset-upload-form').hide();
	};

	ls.photoset.upload = function()
	{
		ls.photoset.closeForm();
		ls.photoset.addPhotoEmpty();
		ls.ajaxSubmit(aRouter['photoset']+'upload/',$('#photoset-upload-form'),function(data){
			if (data.bStateError) {
				$('#photoset_photo_empty').remove();
				ls.msg.error(data.sMsgTitle,data.sMsg);
			} else {
				ls.photoset.addPhoto(data);
			}
		});
	};




	ls.user.showResizeAvatar = function(sImgFile) {
		// if (this.jcropAvatar) {
		// 	this.jcropAvatar.destroy();
		// }
		$('#avatar-resize-original-img').attr('src',sImgFile+'?'+Math.random());
		$('#avatar-resize').show();
		var $this=this;
		// $('#avatar-resize-original-img').Jcrop({
		// 	aspectRatio: 1,
		// 	minSize: [32,32]
		// },function(){
		// 	$this.jcropAvatar=this;
		// 	this.setSelect([0,0,500,500]);
		// });
	};

	/**
	 * Выполняет ресайз аватарки
	 */
	ls.user.resizeAvatar = function() {
		// if (!this.jcropAvatar) {
		// 	return false;
		// }
		var url = aRouter.settings+'profile/resize-avatar/';
		// var params = {size: this.jcropAvatar.tellSelect()};
		var params = {};

		ls.hook.marker('resizeAvatarBefore');
		ls.ajax(url, params, function(result) {
			if (result.bStateError) {
				ls.msg.error(null,result.sMsg);
			} else {
				$('#avatar-img').attr('src',result.sFile+'?'+Math.random());
				$('#avatar-resize').hide();
				$('#avatar-remove').show();
				$('#avatar-upload').text(result.sTitleUpload);
				ls.hook.run('ls_user_resize_avatar_after', [params, result]);
			}
		});

		return false;
	};
	/**
	 * Отмена ресайза аватарки, подчищаем временный данные
	 */
	ls.user.cancelAvatar = function() {
		var url = aRouter.settings+'profile/cancel-avatar/';
		var params = {};

		ls.hook.marker('cancelAvatarBefore');
		ls.ajax(url, params, function(result) {
			if (result.bStateError) {
				ls.msg.error(null,result.sMsg);
			} else {
				$('#avatar-resize').hide();
				ls.hook.run('ls_user_cancel_avatar_after', [params, result]);
			}
		});

		return false;
	};
	/**
	 * Загрузка временной фотки
	 * @param form
	 * @param input
	 */
	ls.user.uploadFoto = function(form,input) {
		if (!form && input) {
			var form = $('<form method="post" enctype="multipart/form-data"></form>').css({
				'display': 'none'
			}).appendTo('body');
			var clone=input.clone(true);
			input.hide();
			clone.insertAfter(input);
			input.appendTo(form);
		}

		ls.ajaxSubmit(aRouter['settings']+'profile/upload-foto/',form,function(data){
			if (data.bStateError) {
				ls.msg.error(data.sMsgTitle,data.sMsg);
			} else {
				this.showResizeFoto(data.sTmpFile);
			}
		}.bind(this));
	};

	/**
	 * Показывает форму для ресайза фотки
	 * @param sImgFile
	 */
	ls.user.showResizeFoto = function(sImgFile) {
		// if (this.jcropFoto) {
		// 	this.jcropFoto.destroy();
		// }
		$('#foto-resize-original-img').attr('src',sImgFile+'?'+Math.random());
		$('#foto-resize').show();
		var $this=this;
		// $('#foto-resize-original-img').Jcrop({
		// 	minSize: [32,32]
		// },function(){
		// 	$this.jcropFoto=this;
		// 	this.setSelect([0,0,500,500]);
		// });
	};
	/**
	 * Выполняет ресайз фотки
	 */
	ls.user.resizeFoto = function() {
		// if (!this.jcropFoto) {
		// 	return false;
		// }
		var url = aRouter.settings+'profile/resize-foto/';
		// var params = {size: this.jcropFoto.tellSelect()};
		var params = {};

		ls.hook.marker('resizeFotoBefore');
		ls.ajax(url, params, function(result) {
			if (result.bStateError) {
				ls.msg.error(null,result.sMsg);
			} else {
				$('#foto-img').attr('src',result.sFile+'?'+Math.random());
				$('#foto-resize').hide();
				$('#foto-remove').show();
				$('#foto-upload').text(result.sTitleUpload);
				ls.hook.run('ls_user_resize_foto_after', [params, result]);
			}
		});

		return false;
	};


	/**
	 * Отмена ресайза фотки, подчищаем временный данные
	 */
	ls.user.cancelFoto = function() {
		var url = aRouter.settings+'profile/cancel-foto/';
		var params = {};

		ls.hook.marker('cancelFotoBefore');
		ls.ajax(url, params, function(result) {
			if (result.bStateError) {
				ls.msg.error(null,result.sMsg);
			} else {
				$('#foto-resize').hide();
				ls.hook.run('ls_user_cancel_foto_after', [params, result]);
			}
		});

		return false;
	};






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

			if (type == 'blog' || type == 'user') {
				$('#'+this.options.prefix_total+type+'_alt_'+idTarget).text(result.iRating);
				divTotal.empty();
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


	ls.userfield.showAddForm = function(obj){
		$('#userfield_form').insertAfter($('#userfield_form_show'));
		$('#user_fields_form_name').val('');
		$('#user_fields_form_title').val('');
		$('#user_fields_form_id').val('');
		$('#user_fields_form_pattern').val('');
		$('#user_fields_form_type').val('');
		$('#user_fields_form_action').val('add');
		$('#userfield_form').slideDown(); 
	};
	
	ls.userfield.showEditForm = function(id, obj) {
		console.log($(obj));
		$('#userfield_form').insertAfter($(obj).parent().parent());
		$('#user_fields_form_action').val('update');
		var name = $('#field_'+id+' .userfield_admin_name').text();
		var title = $('#field_'+id+' .userfield_admin_title').text();
		var pattern = $('#field_'+id+' .userfield_admin_pattern').text();
		var type = $('#field_'+id+' .userfield_admin_type').text();
		$('#user_fields_form_name').val(name);
		$('#user_fields_form_title').val(title);
		$('#user_fields_form_pattern').val(pattern);
		$('#user_fields_form_type').val(type);
		$('#user_fields_form_id').val(id);
		$('#userfield_form').slideDown(); 
	};

	ls.userfield.applyForm = function(){
		$('#userfield_form').slideDown(); 
		if ($('#user_fields_form_action').val() == 'add') {
			this.addUserfield();
		} else if ($('#user_fields_form_action').val() == 'update')  {
			this.updateUserfield();
		}
	};

	ls.userfield.hideForm = function(){
		$('#userfield_form').slideUp();
		return false;
	};

	ls.userfield.addUserfield = function() {
		var name = $('#user_fields_form_name').val();
		var title = $('#user_fields_form_title').val();
		var pattern = $('#user_fields_form_pattern').val();
		var type = $('#user_fields_form_type').val();

		var url = aRouter['admin']+'userfields';
		var params = {'action':'add', 'name':name,  'title':title,  'pattern':pattern,  'type':type};
		
		ls.hook.marker('addUserfieldBefore');
		ls.ajax(url, params, function(data) { 
			if (!data.bStateError) {
				liElement = $('<div class="userfield-item" id="field_'+data.id+'"><span class="userfield_admin_name"></span > / <span class="userfield_admin_title"></span> / <span class="userfield_admin_pattern"></span> / <span class="userfield_admin_type"></span>'
					+'<div class="userfield-actions"><a class="icon-edit" href="javascript:ls.userfield.showEditForm('+data.id+')"></a> '
					+'<a class="icon-delete" href="javascript:ls.userfield.deleteUserfield('+data.id+')"></a></div>')
				;
				$('#user_field_list').append(liElement);
				$('#field_'+data.id+' .userfield_admin_name').text(name);
				$('#field_'+data.id+' .userfield_admin_title').text(title);
				$('#field_'+data.id+' .userfield_admin_pattern').text(pattern);
				$('#field_'+data.id+' .userfield_admin_type').text(type);
				ls.msg.notice(data.sMsgTitle,data.sMsg);
				ls.hook.run('ls_userfield_add_userfield_after',[params, data],liElement);
			} else {
				ls.msg.error(data.sMsgTitle,data.sMsg);
			}
		});
	};


	ls.msg = (function ($) {
		/**
		* Опции
		*/
		this.options = {
			class_notice: 'n-notice',
			class_error: 'n-error'
		};

		/**
		* Отображение информационного сообщения
		*/
		this.notice = function(title,msg){
			this.init();
			$.notifier.broadcast(title, msg, this.options.class_notice);
		};

		/**
		* Отображение сообщения об ошибке
		*/
		this.error = function(title,msg){
			this.init();
			$.notifier.broadcast(title, msg, this.options.class_error);
		};

		this.init = function(){
			if ($('#notifier').length == 0) $('body').append('<div id="notifier" />');
			$('#notifier').width($(window).width());
			var doc = document.documentElement, body = document.body;
			$('#notifier').css('top', (doc && doc.scrollTop || body && body.scrollTop || 0));
		};

		return this;
	}).call(ls.msg || {},jQuery);

	$(window).resize(function () {
		$('#notifier').empty();
	});
	$(window).scroll(function () {
		$('#notifier').empty();
	});



	$('.js-registration-form-show').click(function(){
		if (ls.blocks.switchTab('registration','popup-login')) {
			$('#window_login_form').show();
		} else {
			window.location=aRouter.registration;
		}
		return false;
	});

	$('.js-login-form-show').click(function(){
		if (ls.blocks.switchTab('login','popup-login')) {
			$('#window_login_form').show();
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

		$('.slide-trigger').not(obj).removeClass('active');
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