// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require leaflet
//= require jquery3
//= require popper
//= require bootstrap-sprockets




function writeCoordinates(){
  if (navigator.geolocation) {
	  navigator.geolocation.getCurrentPosition(function (position) {
	  	var lat = position.coords.latitude,
					lng = position.coords.longitude;
			$('#latitude').val(lat);
			$('#longitude').val(lng);
			map.setView([lat, lng], 13);
			marker.setLatLng(map.getCenter());
	  });
	} else {
	  alert("Geolocation is not supported by this browser! Upgrade!");
	}
	iniMap(map); 
  event.preventDefault();

}

function getCenter(){
	var cnt = map.getCenter();
  marker.setLatLng(cnt);
  $('#latitude').val(cnt.lat);
	$('#longitude').val(cnt.lng);
	$('#legend')[0].innerHTML = convertDMS(cnt.lat,cnt.lng);
}

function iniMap(map){
	map.options.scrollWheelZoom = 'center';
  map.options.doubleClickZoom = 'center';
  map.options.touchZoom = 'center';

  var legend = L.control({position: 'bottomleft'});

	legend.onAdd = function (map) {

    var div = L.DomUtil.create('div', 'info legend leaflet-control-attribution');
    div.innerHTML = "<div id='legend'>-</div>";

    return div;
	};

	legend.addTo(map);

}

function convertDMS( lat, lng ) {
 
  var convertLat = Math.abs(lat);
  var LatDeg = Math.floor(convertLat);
  var LatSeg = (convertLat - LatDeg) * 3600
  var LatMin = Math.floor(LatSeg / 60);
  LatSeg = Math.floor(LatSeg - (LatMin * 60));
  var LatCardinal = ((lat > 0) ? "N" : "S");
   
  var convertLng = Math.abs(lng);
  var LngDeg = Math.floor(convertLng);
  var LngSeg = (convertLng - LngDeg) * 3600
  var LngMin = Math.floor(LngSeg / 60);
  LngSeg = Math.floor(LngSeg - (LngMin * 60));
  var LngCardinal = ((lng > 0) ? "E" : "W");
   
  return LatDeg + 'º' + LatMin + '′' + LatSeg + '″' + LatCardinal   + " " + LngDeg + 'º' + LngMin + '′' + LngSeg + '″' + LngCardinal;
}