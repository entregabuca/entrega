(function($) {
  document.addEventListener("turbolinks:load", function() {
    $('.btn-calcualte-price').on( "click", function() {
			getDistanceBetweenOrderPointsInKm()
   	 	var cost = 0
			var basecost = 6000
			var baseDistance = 4
			var valueKm = 1200
			var k = 1

			function roundNumber(number) {  
			  return (Math.round(number * 100)/100).toFixed(2);
			}

			function chargeOver4k (){
			  calchargaGretaer4k = (basecost  + (valueKm * roundedDistanceDifference / k))
			  var roundedcalchargaGretaer4k = roundNumber(calchargaGretaer4k)
			  return calchargaGretaer4k
			}

			var distanceBOP = getDistanceBetweenOrderPointsInKm()
			var roundedDistanceBOP = roundNumber(distanceBOP) 
			console.log("Rounded Distance BOPP= " + roundedDistanceBOP)

			var distanceDifference = (distanceBOP - baseDistance) // 4km
			var roundedDistanceDifference = roundNumber(distanceDifference)
			console.log("Rounded Distance Difference : " + roundedDistanceDifference) 			

			function totalCost (){
			  if (roundedDistanceBOP <= 4){
			    cost = basecost
			    console.log("DOWN COST =" + cost)
			    return cost = basecost
			  } else {
			    cost = chargeOver4k ()
			    console.log("UPPER COST =" + cost)
			    return cost = chargeOver4k ()
			  }
			}

		$('input[name="order[cost]').val(totalCost)
		
		})
	})
})(jQuery)


























//(function($) {
//  document.addEventListener("turbolinks:load", function() {
//    
//      var latitude0 = $('input[id="latitude0"]').val()
//      var latitude1 = $('input[id="latitude1"]').val()
//      var longitude0 = $('input[id="longitude0"]').val()
//      var longitude1 = $('input[id="longitude1"]').val()
//      var R = 6371; // Radius of the earth in km
//
//	function getDistanceFromLatLonInKm() {
//      if ((latitude1 == latitude0) && (longitude0 == longitude1)) {
//        return 0
//      }
//      else {
//
//      function deg2rad(deg) {
//        return deg * (Math.PI/180)
//      }
//
//      var diffLat = deg2rad(latitude1 - latitude0)
//      var diffLon = deg2rad(longitude1 - longitude0)
//      var a = 
//        Math.sin(diffLat/2) * Math.sin(diffLat/2) +
//        Math.cos(deg2rad(latitude0)) * Math.cos(deg2rad(latitude1)) * 
//        Math.sin(diffLon/2) * Math.sin(diffLon/2)
//      var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
//      var d = R * c; // Distance in km
//      return d
//      }
//	}
//	console.log(getDistanceFromLatLonInKm()) // For visualization only.
//
//		var mn = getDistanceFromLatLonInKm()
//		//console.log(mn)
//
//	//	function cost(mn){
//	//		mn
//	//		return (mn)
//	//	}
//	//	
//	//	//alert(cost(mn))
//	//	console.log(cost(mn))
//
//// ================================== \\ =====================
////correcto
//    //console.log(getDistanceFromLatLonInKm()) // For visualization only.
//    //$('input[name="order[distance]').val(getDistanceFromLatLonInKm())
//
//
//// ================================== \\ =====================
//
//    //var distaceCrowflies = getDistanceFromLatLonInKm()
//
//    //function cost(distaceCrowflies){
//		//var searchAddress = $( "a.btn-address-search" )
//		 //var getDis = getDistanceFromLatLonInKm()
//		//car = 2
//		//searchAddress.on( "click", function() {
//			//$('input[name="order[distance]').val(getDis)
//		//});
//	//}
//    //return distaceCrowflies
//  })  
//})(jQuery)
////alert(getDistanceFromLatLonInKm())
////
//////var distaceCrowflies = $('input[name="order[distance]').val(getDistanceFromLatLonInKm())
////distaceCrowflies 
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//