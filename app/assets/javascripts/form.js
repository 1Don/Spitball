$(document).ready(function() {
	$('#focus-field').focus();
});
var card;
function toggleInfo(id) {
	card = document.getElementById('info-card-' + id)
	if (card.style.display == "block"){
		card.style.display = "none";
	} else {
		card.style.display = "block";
	}
};

$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip(); 
});