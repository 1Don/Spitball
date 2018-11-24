$(document).on('turbolinks:load', function(){
  $('.link-field').hide()
  $('.external-link').on('click', function(){
    $('.link-field').slideToggle()
  })
  $('#defaultOpen')[0].click()
})
