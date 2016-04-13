


$(".back-button").on( "click", function(event) {
	event.preventDefault();
	alert("reached back");
  window.history.back();
});