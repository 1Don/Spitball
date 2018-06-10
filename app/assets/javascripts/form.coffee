$(document).ready ->
	$('#index-form').hide()
	$('open-btn').click ->
		$('#index-form').show()
		return
	$('#close-btn').click ->
		$('#index-form').hide()
		return
