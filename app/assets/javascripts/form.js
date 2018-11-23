$(document).on('turbolinks:load', function(){
    $('[data-toggle="tooltip"]').tooltip();
    $('.reply-hide-area').hide()
    $('.hidden_wad_icon').hide()
    $('.hidden_icon').hide()

    //Handles file upload
    function pullFilename(e){
      var input = e.srcElement
      var fileName = input.files[0].name
      for (var i = 0; i < document.getElementsByClassName('fileName').length; i++) {
        document.getElementsByClassName('fileName')[i].innerHTML = `<label class="pointer mt-2" for="wad_image"><i class="fa fa-upload"></i> ${fileName}</label>`
      }
    }

    var fileInputField = document.getElementsByClassName('inputfile')
    for (var i = 0; i < fileInputField.length; i++) {
      fileInputField[i].addEventListener('change', pullFilename)
    }
});
