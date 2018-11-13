$(document).on('turbolinks:load', function() {
  $(".accordion").hide()
  $("#convo-btn").click(function(){
    if ($("#convoz").is(":visible")){
      $("#convoz").slideToggle()
    } else {
      $(".accordion").hide()
      $("#convoz").slideToggle()
    }
  })
  $("#docu-btn").click(function(){
    if ($("#docuz").is(":visible")){
      $("#docuz").slideToggle()
    } else {
      $(".accordion").hide()
      $("#docuz").slideToggle()
    }
  })
  
  var convo_id = getUrlParam('conversation_id', 'Empty')

  if (convo_id != "Empty"){
    $(".convo-" + convo_id).click()
  } else {
    $("#defaultOpen").click()
  }
  $("#conversation-id-field").val($('#defaultOpen').attr('value'))
})
