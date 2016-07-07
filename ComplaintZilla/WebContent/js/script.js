/*******************************************************************************
 * 
 * Project Name: SimpleAdmin CMS Theme Project Description: A clean admin theme
 * File Name: script.js Author: Adi Purdila Author URI:
 * http://www.adipurdila.com Version: 1.0.0
 * 
 ******************************************************************************/
window.onerror = function() {
	// Returning true informs the browser,
	// that the error has been taken care of
	return true;
};

$(document).ready(function() {

	// Content boxes expand/collapse
	$(".initial-expand").hide();

	$("div.content-module-heading").click(function() {
		$(this).next("div.content-module-main").slideToggle();

		$(this).children(".expand-collapse-text").toggle();
	});

});
