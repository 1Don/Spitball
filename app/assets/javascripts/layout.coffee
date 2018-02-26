myFunction = ->
  if window.pageYOffset >= sticky
    navbar.classList.add 'sticky'
  else
    navbar.classList.remove 'sticky'
  return

window.onscroll = ->
  myFunction()
  return

# Get the navbar
navbar = document.getElementById('navbar-custom')
# Get the offset position of the navbar
sticky = navbar.offsetTop