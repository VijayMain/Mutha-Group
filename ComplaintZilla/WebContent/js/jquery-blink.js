window.onerror = function() {
	// Returning true informs the browser,
	// that the error has been taken care of
	return true;
};

(function($) {
	$.fn.blink = function(options) {
		var defaults = {
			delay : 400
		};
		var options = $.extend(defaults, options);

		return this.each(function() {
			var obj = $(this);
			setInterval(function() {
				if ($(obj).css("visibility") == "visible") {
					$(obj).css('visibility', 'hidden');
				} else {
					$(obj).css('visibility', 'visible');
				}
			}, options.delay);
		});
	};
}(jQuery));

(function($) {
	$.fn.blinkst = function(options) {
		var defaults = {
			delay : 400
		};
		var options = $.extend(defaults, options);

		return this.each(function() {
			var obj = $(this);
			setInterval(function() {
				if ($(obj).css("visibility") == "visible") {
					$(obj).css('visibility', 'hidden');
				} else {
					$(obj).css('visibility', 'visible');
				}
			}, options.delay);
		});
	};
}(jQuery));