$(document).on('turbolinks:load', function(){
  $('.link-field').hide()
  $('.external-link').on('click', function(){
    $('.link-field').slideToggle()
  })
  if ($('#defaultOpen')[0]){$('#defaultOpen')[0].click()}
})
