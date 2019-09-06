    
function getDistanceBetweenOrderPointsInKm() { 

  var latitude0 = map0.getCenter().lat
  var latitude1 = map1.getCenter().lat
  var longitude0 = map0.getCenter().lng
  var longitude1 = map1.getCenter().lng
  var yesChecked = $('input[name="order[return]"]:checked').val() 
  var R = 6371 // Radius of the earth in km
  d = 0

  function deg2rad(deg) {
    return deg * (Math.PI/180)
  }

  var diffLat = deg2rad(latitude1 - latitude0)
  var diffLon = deg2rad(longitude1 - longitude0)
  var a = 
  Math.sin(diffLat/2) * Math.sin(diffLat/2) +
  Math.cos(deg2rad(latitude0)) * Math.cos(deg2rad(latitude1)) * 
  Math.sin(diffLon/2) * Math.sin(diffLon/2)
  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
  var d = R * c; // Distance in km

  if (yesChecked == "true"){
    d = d * 2 
    return d 
  } else {
    return d 
  }

       
}