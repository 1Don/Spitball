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

  $(document)
    .one('focus.autoExpand', 'textarea.autoExpand', function(){
        var savedValue = this.value;
        this.value = '';
        this.baseScrollHeight = this.scrollHeight;
        this.value = savedValue;
    })
    .on('input.autoExpand', 'textarea.autoExpand', function(){
        var minRows = this.getAttribute('data-min-rows')|0, rows;
        this.rows = minRows;
        rows = Math.ceil((this.scrollHeight - this.baseScrollHeight) / 16);
        this.rows = minRows + rows;
    });
})
