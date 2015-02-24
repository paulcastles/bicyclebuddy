 $( document ).ready(function() {
    
      function initialize() {
        var mapOptions = {
          center: { lat: 53.347, lng: -6.251},
          zoom: 13
        };
        var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
        $.each(stations, function(index, station) {
          var stationLatlng = new google.maps.LatLng(station.latitude,station.longitude);
          var marker = new google.maps.Marker({
            position: stationLatlng,
            map: map,
            title: station.name
          });
        });
        
      }

      google.maps.event.addDomListener(window, 'load', initialize);
   
      

        
 });