$item = $('.carousel-item')
$wHeight = $(window).height()
$item.height $wHeight
$item.addClass 'full-screen'
$('.carousel img').each ->
  $src = $(this).attr('src')
  $color = $(this).attr('data-color')
  $(this).parent().css
    'background-image': 'url(' + $src + ')'
    'background-color': $color
  $(this).remove()
  return
$(window).on 'resize', ->
  $wHeight = $(window).height()
  $item.height $wHeight
  return