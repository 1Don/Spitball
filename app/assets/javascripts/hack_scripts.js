//Hacks for notifications
function sendPost() {
	$.post('/notifications/mark_as_read')
}

//Hacks for landing page scroll

$(document).on('turbolinks:load', function() {
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
	const orig = $('#comment-tab-open').html()
	$('#comments-display').hide()
	$('#comment-tab-open').click(function(){
		$('#comments-display').show();
		$('#comment-tab-open').html('')
	});
	$('#comment-tab-close').click(function(){
		$('#comments-display').hide()
		$('#comment-tab-open').html(orig)
	})
})

var toggleModal = function(){
	if ($('#signup-modal').css("display") == "none") {
		$('#signup-modal').css("display", "block")
	} else {
		$('#signup-modal').css("display", "none")
	}
};
