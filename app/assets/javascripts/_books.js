// -------------------------------------------------------------------------- //
// -- Select2 for Book Category --------------------------------------------- //
// -------------------------------------------------------------------------- //
$(document).on('ready page:change', function(){
    $(".select-book-category").select2();

    $(".select-book-category").on("select2:open", function(){
        $(".select2-search__field").attr("placeholder", "Search in Categories");
    });

    $(".select-book-category").on("select2:close", function(){
        $(".select2-search__field").attr("placeholder", null);
    });
});

// -------------------------------------------------------------------------- //
// -- Froala Editor --------------------------------------------------------- //
// -------------------------------------------------------------------------- //
$(document).on('ready page:change', function(){
    $(function(){
        $('#book-description').froalaEditor({
            width: 539,
            placeholderText: 'Type description for your ad...',
            toolbarButtons: ['bold', 'italic', 'underline', 'strikeThrough', 'color', 'paragraphFormat', '|',
                'align', 'formatOL', 'formatUL']
        })
    });

    $.FroalaEditor.DEFAULTS.key = 'EsrqA3H-8A-63B-31oiczyqA-7I-7vmC2yeC-9==';
});

// -------------------------------------------------------------------------- //
// -- Autonumeric ----------------------------------------------------------- //
// -------------------------------------------------------------------------- //
$(document).on('ready page:change', function(){
    $(document).trigger('refresh_autonumeric');
});
