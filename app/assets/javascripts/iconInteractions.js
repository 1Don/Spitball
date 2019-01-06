
//Runs all setters
function seeReply(id){
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

function execReply(id){
	setVal(id);
	setFormId(id);
	$('.cancel-btn').hide()
	$('.form-field').val(null);
	$('.comment-reply-btn').css("opacity", "0.5")
	if ($("#cmt-form-" + id).is(":hidden")){
		$(".cmt-forms").hide();
		$("#cmt-form-" + id).slideToggle()
	}else{
		$("#cmt-form-" + id).slideToggle();
	}
}

function secondaryReply(cmt_id, id, name) {
	execReply(id);
	$('.comment-reply-btn').css("opacity", "1")
	setVal(id);
	setReply(cmt_id, name);
}

function focusForm(id){
	$("#comment-reply-box-" + id).focus()
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
