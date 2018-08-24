$(document).on('turbolinks:load', function() {
	$('#disc_nav_menu').hide()
	$('#disc_nav_btn').click(function(){
		$('#disc_nav_menu').slideToggle()
	})
})