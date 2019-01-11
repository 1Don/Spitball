$(document).on('turbolinks:load', function() {
  function tweakHeight(){
    var heightNumber = document.body.offsetHeight - document.getElementById('header').offsetHeight;
    document.getElementById('convo-display-container').style.height = heightNumber.toString() + "px";
    console.log("height tweaked");
  }
  if (document.getElementById('convo-display-container')){tweakHeight()};


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

  $('.message_document').change(function(){
    alert('Your file has been attached!')
  });

  var convo_id = getUrlParam('conversation_id', 'Empty')
  if (convo_id != "Empty"){
    $("#convo-" + convo_id)[0].click()
    $("#mini-convo-" + convo_id)[0].click()
    $(".conversation_id").val(convo_id)
    $('div[data-id=' + convo_id + ']').addClass(" current_convo")
  } else {
    if ($(".main-convo")[0]){
      $(".main-convo")[0].click();
      document.getElementById($('.main-convo')[0].getAttribute('value')).scrollTop = document.getElementById($('.main-convo')[0].getAttribute('value')).scrollHeight;
      $(".main-convo")[0].addClass(" current_convo");
    }
    if ($(".little-convo")[0]){
      $(".little-convo")[0].click()
      document.getElementById($('.main-convo').attr('value')).scrollTop = document.getElementById($('.main-convo').attr('value')).scrollHeight;
    }
  }

})
