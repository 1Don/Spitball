$(document).on('turbolinks:load', function() {
	const gooey = ["hey", "I just met you", "and this is crazy"]
	var fullRequest = $.ajax({
		url: "/friends.json",
		type: "GET",
		dataType: "JSON",
		success: function(data){
			console.log(data)
			const names_Arr = []
			for (x in data){
				names_Arr.push(data[x].name)
			}
			autoCompleter(names_Arr)
		}
	})
	var autoCompleter  = function(friendsList) {
		$("#autocomplete_friends").autocomplete({
			source: friendsList,
			message: {
				noResults: '',
				resuts: ''
			}

		})
	}
	$("#autocomplete_friends").focus(function(){
		if (fullRequest === undefined || fullRequest === null) {
			document.location.reload()
		}
	})
})