//Hacks for notifications
function sendPost() {
	$.post('/notifications/mark_as_read')
}

//Hacks for landing page scroll
$(document).ready(function() {
	$("#landing-btn").click(function() {
	    $('html,body').animate({
	        scrollTop: $("#what-we-do").offset().top},
	        'slow');
	});	
	$('#nav-menu').hide();
	$('#menu-btn').click(function(){
		$('#wad-new-form').hide();
		$('#nav-menu').show()
	});
	$('#new-wad-btn').click(function(){
		$('#nav-menu').hide();
		$('#wad-new-form').show()
	});

})

$(document).on('turbolinks:load', function() {
	$('#nav-menu').hide();
	$('#menu-btn').click(function(){
		$('#wad-new-form').hide();
		$('#nav-menu').show()
	});
	$('#new-wad-btn').click(function(){
		$('#nav-menu').hide();
		$('#wad-new-form').show()
	});	
})

var toggleModal = function(){
	if ($('#signup-modal').css("display") == "none") {
		$('#signup-modal').css("display", "block")
	} else {
		$('#signup-modal').css("display", "none")
	}
};
