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
		function resize() {
			item_width = obj.width();
			items.width(item_width);
			container.width(items_count * item_width);
			inner.height(items.eq(index).find('.sg-item-inner').height());
		};

		// Update counter
		function update_counter() {
			counter.text(index + 1);
		};

		// Go to slide
		function go_to_slide(slide_index) {
			update_counter();
			inner.height(items.eq(slide_index).find('.sg-item-inner').height());
			container.css('marginLeft', -item_width * slide_index);
		};

		// Go to next slide
		function next() {
			index < items_count - 1 ? index++ : index = 0;
			go_to_slide(index);
		};

		// Go to previous slide
		function prev() {
			index > 0 ? index-- : index = items_count - 1;
			go_to_slide(index);
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
			update_counter();

			// Bind gestures
			obj.swipe({
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
				if (index != 0) {
					index = 0;
					go_to_slide(index);
				}
				resize();
			});
		});
	};
})(jQuery);