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
    $("#convo-" + convo_id).click()
    $("#mini-convo-" + convo_id).click()
    $(".conversation_id").val(convo_id)
    console.log(convo_id);
    $('div[data-id=' + convo_id + ']').addClass(" current_convo")
    console.log("Prelist");
    console.log($('div[data-id=' + convo_id + ']').attr("class"));
  } else {
    $("#defaultOpen").click()
    $(".conversation_id").val($('#defaultOpen').attr('value'))
    console.log("empty - " + $('#defaultOpen').attr('value'));
  }

})
