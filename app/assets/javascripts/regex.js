(function($){
	$.regex = $.regex || {};
	$.extend($.regex, {
		isEmail: function(email) {
			return (/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/.test(email));
		},
		isPhone: function(phone) {
			return /^((\d{11,12})|(\d{3,4}-\d{8})|(\d{4}-\d{7})|(\d{3,4}-\d{4}-\d{4}))$/.test(phone);
		},
		isMobile: function(mobile) {
			return (/^(13[0-9]|15[012356789]|18[0-9]|14[57]|170)[0-9]{8}$/.test(mobile));
		}
	});
})(jQuery);