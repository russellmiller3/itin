
log("Event.js Loaded");

var createNewEventOnSubmit = function() {

	$('.events').on('submit', 'form[name="new_event"]', function(evt){
		log("New event form submitted")
		evt.preventDefault();

		var $newEventForm = $(this);

		var actionPath = $newEventForm.attr('action');

		var newEventFormData = $newEventForm.serialize();

		log("Sending POST request to " + actionPath);

		$.post(actionPath, newEventFormData, function(newEventHTML) {
			log("Received response from POST request to " + actionPath);

			log("Adding new event element to list");

	    $newEventForm.parent('li').before(newEventHTML);

	    log("Resetting new event form")
	    $newEventForm.get(0).reset();
	  });
	});
};

$(document).ready(function() {
  createNewEventOnSubmit();

});