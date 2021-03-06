// -------------------------------------------------------------------------- //
// -- Show Last Received Messages ------------------------------------------- //
// -------------------------------------------------------------------------- //

$(document).on('ready page:load', function(){
    var objDiv = document.getElementById("messages-wrapper");
    objDiv.scrollTop = objDiv.scrollHeight;
});

// -------------------------------------------------------------------------- //
// -- Auto Expand Textarea -------------------------------------------------- //
// -------------------------------------------------------------------------- //

$(document).on('ready page:load', function(){
    var t = document.getElementsByTagName('textarea')[0];
    var offset = !window.opera ? (t.offsetHeight - t.clientHeight) : (t.offsetHeight + parseInt(window.getComputedStyle(t, null).getPropertyValue('border-top-width')));

    var resize = function (t){
        t.style.height = 'auto';
        t.style.height = (t.scrollHeight + offset ) + 'px';
    }

    t.addEventListener && t.addEventListener('input', function (event){
        resize(t);
    });

    t['attachEvent'] && t.attachEvent('onkeyup', function (){
        resize(t);
    });
});