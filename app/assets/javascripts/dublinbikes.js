$( document ).ready(function() {
    
   function initialize() {
     var mapOptions = {
       center: { lat: 53.347, lng: -6.251},
       zoom: 13,
       scrollwheel: false
     };
     var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

     infowindow = new google.maps.InfoWindow();
     infowindowContent = "";


     $.each(stations, function(index, station) {
       var image = 'http://bicyclebuddy-193553.euw1-2.nitrousbox.com/assets/marker.png';
       var stationLatlng = new google.maps.LatLng(station.latitude,station.longitude);
       var marker = new google.maps.Marker({
         position: stationLatlng,
         map: map,
         title: station.name,
         icon: image
       });
       
       google.maps.event.addListener(marker, 'click', function() {
         if (infowindow) {
           infowindow.close();
         }
         getStationData(station.number, map, marker);
       });
     });
     
     var cyclePlanCoordinates = $( "#map-container" ).data("route");
  
     var cyclePlanLatLngsArray = [];
     $.each(cyclePlanCoordinates, function(index, point) {
       cyclePlanLatLngsArray.push(new google.maps.LatLng(point[0], point[1]));
     });

       var cyclePath = new google.maps.Polyline({
         path: cyclePlanLatLngsArray,
         geodesic: true,
         strokeColor: '#FF0000',
         strokeOpacity: 1.0,
         strokeWeight: 2
       });

       cyclePath.setMap(map);


   }

   google.maps.event.addDomListener(window, 'load', initialize);
        
});

function getStationData(stationNumber, map, marker) {
  var url = "https://api.jcdecaux.com/vls/v1/stations/" + stationNumber + "?contract=Dublin&apiKey=f41ee417aabaeaa8cd43cc003ef316a5943e4316";
  
  $.getJSON(url, function(json){
    infowindowContent = JSON.stringify(json);
    infowindow.setContent(infowindowContent);
    infowindow.open(map,marker);
  });
 
}