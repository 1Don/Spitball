//Hacks for notifications
function sendPost() {
	$.post('/notifications/mark_as_read')
}
var objDiv;
let new_message;
function openConversation(evt, convoId) {
    // Declare all variables
    var i, tabcontent, tablinks;

    // Get all elements with class="tabcontent" and hide them
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }

    // Get all elements with class="tablinks" and remove the class "active"
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }

    // Show the current tab, and add an "active" class to the button that opened the tab
    document.getElementById(convoId).style.display = "block";
    evt.currentTarget.className += " ";

		history.pushState(null,null, '/conversations/' + convoId);


		objDiv = document.getElementById(convoId);
		objDiv.scrollTop = objDiv.scrollHeight;

		let conversationField = document.getElementById('conversation_id');
		conversationField.value = convoId;
}




//Hacks for landing page scroll

$(document).on('turbolinks:load', function() {
	$("#conversation-id-field").val($('#defaultOpen').attr('value'))

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
