// -------------------------------------------------------------------------- //
// -- Select2 for Roommate Province ----------------------------------------- //
// -------------------------------------------------------------------------- //
$(document).on('ready page:change', function(){
    $(".select-roommate").select2();

    $('.select-roommate').select2({ minimumResultsForSearch: -1 });

    //$(".select-roommate-province").on("select2:open", function(){
    //    $(".select2-search__field").attr("placeholder", "Search in Province");
    //
    //});
    //
    //$(".select-roommate-province").on("select2:close", function(){
    //    $(".select2-search__field").attr("placeholder", null);
    //});
});

// -------------------------------------------------------------------------- //
// -- Select2 for Roommate Province Filter ---------------------------------- //
// -------------------------------------------------------------------------- //
//$(document).on('ready page:change', function(){
//    $(".select-roommates-province-filter").select2();
//
//    $(".select-roommates-province-filter").on("select2:open", function(){
//        $(".select2-search__field").attr("placeholder", "Search in Provinces");
//    });
//
//    $(".select-roommates-province-filter").on("select2:close", function(){
//        $(".select2-search__field").attr("placeholder", null);
//    });
//});

// -------------------------------------------------------------------------- //
// -- Select2 for Roommate City Filter -------------------------------------- //
// -------------------------------------------------------------------------- //
//$(document).on('ready page:change', function(){
//    $(".select-roommates-city-filter").select2();
//
//    $(".select-roommates-city-filter").on("select2:open", function(){
//        $(".select2-search__field").attr("placeholder", "Search in Cities");
//    });
//
//    $(".select-roommates-city-filter").on("select2:close", function(){
//        $(".select2-search__field").attr("placeholder", null);
//    });
//});