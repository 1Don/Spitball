$(document).ready(function() {
	$('#sidebar-item').hover(function() {
		this.css("color", "orange");
		console.log("This works");
	}, function() {
		this.css("color", "white");
	})
})