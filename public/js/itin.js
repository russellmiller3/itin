// A utility function to log information to the console.
var log = function(message) {
	var timestamp = (new Date()).toTimeString();
	console.log('[' + timestamp + ']  ' +  message);
};

var createItinOnSubmit = function() {
	$('.page').on('submit', 'form[name="new_itin"]', function(evt) {
		log("New trip form submitted");

		evt.preventDefault();

		var $newItinForm = $(this);

		var actionPath = $newItinForm('action');
		var newItinFormData = $(this).serialize();

		log("Sending POST request to " + actionPath);

		$.post(actionPath, newItinFormData, function() {
			log("Received response from POST request to " + actionPath);

			log("Showing details of new Trip");
			$newItinForm.parent('section').after(serverResponse);
			$newItinForm.get(0).reset();
		});
	});
};

$(document).ready(function() {
createItinOnSubmit();


}