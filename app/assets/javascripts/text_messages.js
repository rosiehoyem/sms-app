# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('#create_message').on('click', function() { 
    $('#upload').append('<div class="upload_field"><input type="text" name="text_messages[]"><button class="remove">x</button></div>');
    return false; //prevent form submission
});