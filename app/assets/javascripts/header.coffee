$(window).scroll ->
  'use strict'
  windowYmax = 1
  scrolledY = $(window).scrollTop()
  if scrolledY > windowYmax
    $('.header').addClass 'hide-content'
  else
    $('.header').removeClass 'hide-content'
  return

$(document).on('hide.bs.collapse', '#header', ->
  $('.welcome').removeClass('no-offset')
)

$(document).on('show.bs.collapse', '#header', ->
  $('.welcome').addClass('no-offset')
)
