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
