$(window).scroll ->
  'use strict'
  windowYmax = 1
  scrolledY = $(window).scrollTop()
  if scrolledY > windowYmax
    $('.header').addClass 'hide-content'
  else
    $('.header').removeClass 'hide-content'
  return