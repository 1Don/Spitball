$(document).on('turbolinks:load', function() {
	$('#disc_nav_menu').hide()
	$('#disc_nav_btn').click(function(){
		$('#disc_nav_menu').slideToggle()
	})
	document.getElementById("defaultOpen").click()
	var load_screen = document.getElementById("load_screen");
	document.body.removeChild(load_screen);
})
window.addEventListener("load", function(){
	var load_screen = document.getElementById("load_screen");
	document.body.removeChild(load_screen);
});
