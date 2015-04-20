$( document ).ready(function() {
  var skycons = new Skycons({"color": "purple"});
  
  var icon1 = document.getElementById( 'icon1');
  skycons.add(icon1, icon1.className );
  skycons.play();
 
});