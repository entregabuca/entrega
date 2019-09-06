//(function($) {
//  document.addEventListener("turbolinks:load", function() {
//    var address0Value = $('#address0').val()
//    var address1Value = $('#address1').val()
//    var yesChecked = $('input[name="order[return]"]:checked').val()
//    var returnTrue = document.getElementById('order_return_true')
//    var returnFalse = document.getElementById('order_return_false')
//    var topCardh3 = $('.top-card h3').text()
//
//    var latitude0 = $('#latitude0').val()
//    var longitude0 = $('#longitude0').val()
//
//    function translateMapHeadingcomeBack (){
//      if ( topCardh3 == "Detalles de la Orden"){
//        $('.card-body-left h3').html("Dirección de Recogida y Entrega")         
//      } else {
//        $('.card-body-left h3').html("Sending and Receiving Location")        
//      } 
//    }
//
//    function translateMapHeadingcomeBackNot (){
//      if ( topCardh3 == "Detalles de la Orden"){
//        $('.card-body-left h3').html("Direción de Recogida")
//      } else { 
//        $('.card-body-left h3').html("Sending Location") 
//      }
//    }
//
//    function comeBack() {
//      $('.card-right').hide()
//      $('.recipient-card').hide() 
//      translateMapHeadingcomeBack ()
//      $('.maps-row .col-md-6').removeClass( 'col-md-6' ).addClass( 'col-md-12' )
//      $('#address1').val(address0Value)
//      $('#latitude1').val(latitude0)
//      $('#longitude1').val(longitude0)
//      $(".btn-address-search").click()
//    }
//
//    function comeBackNot() {
//      $('.card-right').show()  
//      $('.recipient-card').show()
//      translateMapHeadingcomeBackNot ()
//      $('.maps-row .col-md-12').removeClass( 'col-md-12' ).addClass( 'col-md-6' )
//    }
//
//    if (yesChecked == "true"){
//      comeBack()
//    } else {
//      comeBackNot()
//    }
//
//    returnTrue.addEventListener('click', comeBack);
//    returnFalse.addEventListener('click', comeBackNot);
//  })
//})(jQuery)//