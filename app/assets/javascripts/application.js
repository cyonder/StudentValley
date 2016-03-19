//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require select2
//= require autonumeric

//= require froala_editor.min.js
//= require plugins/paragraph_format.min.js
//= require plugins/align.min.js
//= require plugins/colors.min.js
//= require plugins/lists.min.js

//= require _dashboard
//= require _profiles
//= require _messages
//= require _books
//= require _roommates

$.fn.select2.defaults.set( "theme", "bootstrap" ); // Set default theme for select2

// -------------------------------------------------------------------------- //
// -- Tooltip --------------------------------------------------------------- //
// -------------------------------------------------------------------------- //

$(document).on("ready page:change", function(){
    $('.tag-tooltip').tooltip();
});

// -------------------------------------------------------------------------- //
// -- File Upload ----------------------------------------------------------- //
// -------------------------------------------------------------------------- //

$(document).on('ready page:change', function(){
    $(document).on('change', '.btn-file :file', function (){
        var input = $(this), numFiles = input.get(0).files ? input.get(0).files.length : 1, label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
        input.trigger('fileselect', [
            numFiles,
            label
        ]);
    });

    $('.btn-file :file').on('fileselect', function (event, numFiles, label){
        var input = $(this).parents('.input-group').find(':text'), log = numFiles > 1 ? numFiles + ' files selected' : label;
        if (input.length) {
            input.val(log);
        } else {
            if (log)
                alert(log);
        }
    });
});