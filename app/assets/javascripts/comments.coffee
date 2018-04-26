$(document).on('show.bs.collapse', '.comment', (e) ->
  $("[data-toggle=\"collapse\"][data-target=\"##{$(e.target).attr('id')}\"]").html('Hide replies')
)

$(document).on('hide.bs.collapse', '.comment', (e) ->
  $("[data-toggle=\"collapse\"][data-target=\"##{$(e.target).attr('id')}\"]").html('Show replies')
)
