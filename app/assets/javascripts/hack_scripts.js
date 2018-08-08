//Hacks for notifications
function sendPost() {
	$.post('/notifications/mark_as_read')
}

//Hacks for landing page scroll

$(document).on('turbolinks:load', function() {
	$('#wad-new-form').hide();
	$('#menu-btn').click(function(){
		$('#wad-new-form').hide();
		$('#nav-menu').show()
	});
	$('#new-wad-btn').click(function(){
		$('#nav-menu').hide();
		$('#wad-new-form').show()
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
