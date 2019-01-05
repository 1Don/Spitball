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
    console.log("works");
    $("#convo-" + convo_id)[0].click()
    $("#mini-convo-" + convo_id)[0].click()
    $(".conversation_id").val(convo_id)
    $('div[data-id=' + convo_id + ']').addClass(" current_convo")
  } else {
    if ($(".main-convo")[0]){
      $(".main-convo")[0].click()
    }
    if ($(".little-convo")[0]){
      $(".little-convo")[0].click()
    }
  }

})
