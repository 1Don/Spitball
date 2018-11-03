//Hacks for notifications
function sendPost() {
	$.post('/notifications/mark_as_read')
}

var objDiv;
var new_message;
function openConversation(evt, convoId) {
		console.log("open convo working 1")
    // Declare all variables
    var i, tabcontent, tablinks;

    // Get all elements with class="tabcontent" and hide them
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }

		console.log("open convo working 2")

    // Get all elements with class="tablinks" and remove the class "active"
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" current_convo", "");
    }

    // Show the current tab, and add an "active" class to the button that opened the tab
		for (i = 0; i < document.getElementsByClassName("convo-" + convoId).length; i++){
			console.log(document.getElementsByClassName("convo-" + convoId)[i])
			document.getElementsByClassName("convo-" + convoId)[i].style.display = "block";
		}
    evt.currentTarget.className += " current_convo";

		history.pushState(null,null, '/conversations/' + convoId);


	//	objDiv = document.getElementById(convoId);
	//	objDiv.scrollTop = objDiv.scrollHeight;

		var conversationField = document.getElementById('conversation_id');
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

})

$(document).on('turbolinks:load', function() {
	$('#discussion-panel').mouseover(function(){
		$('#discussion-trash').css("display", "block");
	});
	$('#discussion-panel').mouseleave(function(){
		$('#discussion-trash').css("display", "none");
	});
});
