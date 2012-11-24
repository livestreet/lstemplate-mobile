/*
 * Swipe Gallery
 *
 * Copyright (c) 2012 Shakhov Denis <denis.shakhov@gmail.com>
 * 
 * $Version: 1.0
 */

(function($) {
	$.fn.swipegallery = function() {
		var obj = null;
		var container = null;
		var inner = null;
		var items = null;
		var counter = null;
		var index = 0;
		var items_count = 0;
		var item_width = 0;

		// Resize
		resize = function() {
			item_width = obj.width();
			items.width(item_width);
			container.width(items_count * item_width);
			inner.height(items.eq(index).find('.sg-item-inner').height());
			goToSlide(index);
		};

		// Update counter
		updateCounter = function() {
			counter.text(index + 1);
		};

		// Go to slide
		goToSlide = function(slide_index) {
			inner.addClass('loader');
			updateCounter();

			var img = items.eq(slide_index).find('img');

			if (img.attr('src') == "") {
				img.attr('src', img.data('original'));
			}

			if (img[0].complete) {
				update(slide_index);
			} else {
				img.load(function () {
					if (index == slide_index) update(slide_index);
				});
			}
		};

		// Update viewport
		update = function(slide_index) {
			inner.removeClass('loader');

			inner.height(items.eq(slide_index).css('display', 'table-cell').find('.sg-item-inner').height());
			container.css('marginLeft', -item_width * slide_index);
		};

		// Go to the next slide
		next = function() {
			index < items_count - 1 ? index++ : index = 0;
			goToSlide(index);
		};

		// Go to the previous slide
		prev = function() {
			index > 0 ? index-- : index = items_count - 1;
			goToSlide(index);
		};


		this.each(function () {
			// Init
			obj         = $(this);
			container   = obj.find('ul');
			inner       = obj.find('.sg-inner');
			counter     = obj.find('.sg-pos');

			// Move cover to front
			container.find('.sg-item-cover').prependTo(container);

			items       = container.find('li');
			items_count = items.length;
			
			resize();
			updateCounter();

			// Bind gestures
			inner.swipe({
				swipeLeft: function(event, direction, distance, duration, fingerCount) {
					next();
				},
				swipeRight: function(event, direction, distance, duration, fingerCount) {
					prev();
				}
			});

			// Button navigation
			obj.find('.sg-prev').click(function() {
				prev();
			});

			obj.find('.sg-next').click(function() {
				next();
			});

			// Resize
			$(window).resize(function () {
				resize();
			});
		});
	};
})(jQuery);