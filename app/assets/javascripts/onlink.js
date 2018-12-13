$(document).on('turbolinks:load', function(){
  $('.link-field').hide()
  $('.external-link').on('click', function(){
    $('.link-field').slideToggle()
  })

  function hideSidePics(){
    for (var i = 0; i < document.getElementsByClassName('sidebar-pic').length; i++){
      document.getElementsByClassName('sidebar-pic')[i].style.display = 'none'
    }
  }
  hideSidePics()

  if ($('#walkthrough')[0]){
    $('#walkthrough')[0].click()
  }
})
