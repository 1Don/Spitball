$(document).ready(function(){
  $('.options').hide()
  //$('.reply-hide-area').hide()
  $('.cmt-forms').hide()

  $('.cancel-btn').click(function(){
    $('.form-field').val("");
    $('.comment-reply-btn').css("opacity", "0.5");
    $('.cancel-btn').hide()
    $('.hid-field').val("");
  })
})
function activeBox(id, big = false){
  if (big){
    if ($('#parent-cmt-field').val().length > 0){
      $('#parent-cmt-btn').css("opacity", "1")
    } else {
      $('#parent-cmt-btn').css("opacity", "0.0")
    }
  }else{
    if ($(".form-field-" + id).val().length > 0){
      $('.comment-reply-btn').css("opacity", "1")
      $('.cancel-btn').show()
    } else {
      $('.comment-reply-btn').css("opacity", "0.5")
      $('.cancel-btn').hide()
    }
  }
}
