$( function() {
    init();
    var menuContainer = $( "#Menu" );
    window.addEventListener( 'message', function( event ) {
        var item = event.data;
        
        // Show the menu 
        if ( item.showmenu ) {
            ResetMenu()
            menuContainer.show();
        }

        // Hide the menu 
        if ( item.hidemenu ) {
            menuContainer.hide(); 
        }
    } );

    // Pressing the ESC key with the menu open closes it 
    document.onkeyup = function ( data ) {
        if ( data.which == 27 ) { // Escape key
            if ( menuContainer.is( ":visible" ) ) {
                sendData( "ButtonClick", "exit" )
            }
        }
    };
} )

// Hides all div elements that contain a data-parent, in
// other words, hide all buttons in submenus. 
function ResetMenu() {
    $( "div" ).each( function( i, obj ) {
        var element = $( this );

        if ( element.attr( "data-parent" ) ) {
            element.hide();
        } else {
            element.show();
        }
    } );
}

// Configures every button click to use its data-action, or data-sub
// to open a submenu. 
function init() {
    // Loops through every button that has the class of "menuoption"
    $( ".menuoption" ).each( function( i, obj ) {

        // If the button has a data-action, then we set it up so when it is 
        // pressed, we send the data to the lua side. 
        if ( $( this ).attr( "data-action" ) ) {
            $( this ).click( function() { 
                var data = $( this ).data( "action" ); 

                sendData( "ButtonClick", data ); 
            } )
        }

        // If the button has a data-sub, then we set it up so when it is 
        // pressed, we show the submenu buttons, and hide all of the others.
        if ( $( this ).attr( "data-sub" ) ) {
            var menu = $( this ).data( "sub" );
            var element = $( "#" + menu ); 

            $( this ).click( function() {
                element.show();
                $( this ).parent().hide();  
            } )

            $( this ).hover(
                function() {
                    $( this ).append( $( "<span> >></span>" ) );
                }, function() {
                    $( this ).find( "span:last" ).remove();
                }
            );

            // This small section auto generates a back button for every
            // submenu. 
            var backBtn = $( '<button/>', { text: 'Back' } );
            
            backBtn.click( function() {
                element.hide();
                $( "#" + element.data( "parent" ) ).show();
            } );

            element.append( backBtn );
        }
    } );
}

// Send data to lua for processing.
function sendData( name, data ) {
    $.post( "http://tn_vehicleinteraction/" + name, JSON.stringify( data ), function( datab ) {
        if ( datab != "ok" ) {
            console.log( datab );
        }            
    } );
}