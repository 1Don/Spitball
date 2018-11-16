//Hacks for notifications
function sendPost() {
	$.post('/notifications/mark_as_read')
}

function getUrlVars() {
    var vars = {};
    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
        vars[key] = value;
    });
    return vars;
}
function getUrlParam(parameter, defaultvalue){
    var urlparameter = defaultvalue;
    if(window.location.href.indexOf(parameter) > -1){
        urlparameter = getUrlVars()[parameter];
        }
    return urlparameter;
}

var objDiv;
var new_message;
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
				tablinks[i].className = tablinks[i].className.replace(" current_convo", "");
		}

		// Show the current tab, and add an "active" class to the button that opened the tab
		for (i = 0; i < document.getElementsByClassName("convo-" + convoId).length; i++){
			document.getElementsByClassName("convo-" + convoId)[i].style.display = "block";
		}

		evt.currentTarget.className += " current_convo";


	//	objDiv = document.getElementById(convoId);
	//	objDiv.scrollTop = objDiv.scrollHeight;

		$('.conversation_id').val(convoId)
}


//Hacks for landing page scroll

$(document).on('turbolinks:load', function() {
  $('.reply-hide-area').hide()
	//Scrolls from landing button to about
	$("#landing-btn").click(function() {
	    $('html,body').animate({
	        scrollTop: $("#what-we-do").offset().top},
	        'slow');
	});
})
