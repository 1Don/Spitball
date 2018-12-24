//Runs all setters
function execReply(id){

		$('.form-field').val(null);
		setVal(id);
		setFormId(id);
		toggleReply(id);

		//Toggles reply tree on and off
		function toggleReply(id) {
			if ($('#reply-' + id).is(":hidden")){
				$('.reply-hide-area').slideUp()
				$('.see-replies').html('Show replies <i class="fa fa-caret-down"></i>')
				$('#see-replies-' + id).html('Close replies <i class="fa fa-caret-up"></i>')
				$('#reply-' + id).slideToggle()
			} else {
				$('#see-replies-' + id).html('Show replies <i class="fa fa-caret-down"></i>')
				$('#reply-' + id).slideUp()
			}
		}

}

function focusForm(id){
	$("#comment-reply-box-" + id).focus()
}

function secondaryReply(cmt_id, id, name) {
	setVal(id);
	setReply(cmt_id, name);
}

//Gives each parent_id hidden field its ID
function setVal(id) {
	$('.hid-field').attr('value', id);
};
function setFormId(id) {
	$('.form-field').attr('id', "form-field-" + id);
};
function setReply(id, user) {
	$('.form-field').val("@" + user + " ");
	$('.form-field').focus();
};
