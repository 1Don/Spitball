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
})

var toggleModal = function(){
	if ($('#signup-modal').css("display") == "none") {
		$('#signup-modal').css("display", "block")
	} else {
		$('#signup-modal').css("display", "none")
	}
};