// A utility function to log information to the console.
var log = function(message) {
	var timestamp = (new Date()).toTimeString();
	console.log('[' + timestamp + ']  ' +  message);
};


	log("jquery.js Loaded");
	log("itinerary.js Loaded");


var createitineraryOnSubmit = function() {
	$('.page').on('submit', 'form[name="new_itinerary"]', function(evt) {
		log("New trip form submitted");
		evt.preventDefault();

		var $newitineraryForm = $(this);

    // Use the destination path defined in the form's 'action'
    // attribute, i.e. `/itineraries`
		var actionPath = $newitineraryForm.attr('action');
		var newitineraryFormData = $(this).serialize();

		log("Sending POST request to " + actionPath);

		$.post(actionPath, newitineraryFormData, function(serverResponse) {
      log("Received response from POST request to " + actionPath);

			$newitineraryForm.next('section').after(serverResponse);
      log("Display new itinerary and edit button");

			$newitineraryForm.get(0).reset();

//Post the new itinerary form data to the action path, then run a function on the response.
//This function finds the next section after the form, and inserts the server response after it.
//Then it resets the form.

		});
	});

};



$(document).ready(function() {
createitineraryOnSubmit();


});