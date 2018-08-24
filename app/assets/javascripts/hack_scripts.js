//Hacks for notifications
function sendPost() {
	$.post('/notifications/mark_as_read')
}

//Hacks for landing page scroll

$(document).on('turbolinks:load', function() {
	//Scrolls from landing button to about
	$("#landing-btn").click(function() {
	    $('html,body').animate({
	        scrollTop: $("#what-we-do").offset().top},
	        'slow');
	});	

	$('#wad-new-form').hide();
	if ($(window).width() <= 570 ){
		$('#nav-menu').hide();
	}
	$('#menu-btn').click(function(){
		if ($('#nav-menu').is(":hidden")){
			$('#wad-new-form').hide();
			$('#nav-menu').show()
		} else {
			if ($(window).width() > 600 ){
				$('#nav-menu').show()
				$('#wad-new-form').hide()	
			} else {
				$('#wad-new-form').hide()
				$('#nav-menu').hide()
			}
		}
	});
	$('#new-wad-btn').click(function(){
		if ($('#wad-new-form').is(":hidden")){	
			$('#nav-menu').hide();
			$('#wad-new-form').show()
		} else {
			if ($(window).width() > 600 ){
				$('#nav-menu').hide();
				$('#wad-new-form').show()
			} else {
			$('#wad-new-form').hide()
			$('#nav-menu').hide()
			}
		}
	});	
})

$(document).on('turbolinks:load', function() {
	$('#discussion-panel').mouseover(function(){
		$('#discussion-trash').css("display", "block");
	});
	$('#discussion-panel').mouseleave(function(){
		$('#discussion-trash').css("display", "none");
	});
});
