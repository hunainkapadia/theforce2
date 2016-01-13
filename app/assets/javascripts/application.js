// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//
//Below is a bootstrap requirement
//= require jquery
//= require bootstrap-sprockets

function IsInvalid() {
	//Function below checks values of closed questions.
	//If undefined it returns true, otherwise false.
	//Open question is included, but currently no validation performed on it.

	//Check values below. "undefined" returned if lack of value.
	var closed_q_1 = $('.closed_q_1:checked').val();
	var closed_q_2 = $('.closed_q_2:checked').val();
	var open_q_1 = $('.open_q_1').val();

	//Return proper response and change value of the span field.
	if(closed_q_1 === undefined || closed_q_2 === undefined) {
		$('.validation_response').html('Looks like you have not filled something out.');
		return true;
	} else {
		$('.validation_response').html('');
		return false;
	}
}

function ReturnChars() {
	//Function to calculate number of characters remaining for the open question.
	var allowed_length = 255;
	var q_length = $('.open_q_1').val().length;
	var remaining_length = allowed_length - q_length;

	$('.text_char_count').html(Math.abs(remaining_length));

	if(remaining_length < 0) {
		$('.text_char_over').html("Only the first 255 characters will be recorded.");
		$('.text_char_overlimit').html(" characters over limit");
	} else {
		$('.text_char_over').html("");
		$('.text_char_overlimit').html(" characters remaining");
	}
}

$(document).ready(function() {
	$('.validation_submit_button').click(function() {
		if(IsInvalid()) {
			//Returning false will prevent form from sending.
			return false;
		}
	});

	$('.open_q_1').on('keydown',function () {
		ReturnChars();
	});
});