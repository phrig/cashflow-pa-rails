var initialMap=function(lat, long, token){
  var token="pk.eyJ1Ijoic3Vtb2ZjaGVtaWNhbHMiLCJhIjoiY2luczR0dzdwMTBxYnR0bTM3YndjdDB0bSJ9.ywTjgZ99qLgrty7g_ht2MQ"
  var mymap = L.map('mapid').setView([lat, long], 13);
  L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=' + token, {
      maxZoom: 18,
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
          '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
          'Imagery © <a href="http://mapbox.com">Mapbox</a>',
      id: 'mapbox.streets'
  }).addTo(mymap);
  return mymap
  var markerArray=[];
}

// Was using this before realized needed stuff like name, link, different marker icons
//var drawMap = function(locations, mymap) {
//  var markerArray = [];
//  locations.forEach(function(location){
//    markMap(markerArray, location.latitude, location.longitude, mymap);
//  })
//  if(locations.length > 1) {
//    fitMap(markerArray, mymap);
//  }
//}

var markMap = function(mymap, markerArray, lat, long, description, markerType){
  if(description) {
    if (markerType=="review") {
      marker = new L.marker([lat,long], {icon: reviewIcon}).bindPopup(description).addTo(mymap);
    }
    else {
      marker = new L.marker([lat,long], {icon: officeIcon}).bindPopup(description).addTo(mymap);
    }
  }
  else {
    if (markerType=="review") {
      marker = new L.marker([lat,long], {icon: reviewIcon}).addTo(mymap);
    }
    else {
      marker = new L.marker([lat,long], {icon: officeIcon}).addTo(mymap);
    } 
  }
  markerArray.push(marker);
}

var fitMap = function(mymap, markerArray){
  // If there is more than one location resize to fit them all.
  if(markerArray.length>1) {
    var group = new L.featureGroup(markerArray);
    mymap.fitBounds(group.getBounds());
  }
}

var reviewIcon = L.icon({
    iconUrl: '/assets/images/review-icon.png',
    shadowUrl: '/assets/images/marker-shadow.png',

    iconSize:     [25, 41], // size of the icon
    shadowSize:   [41, 41], // size of the shadow
    iconAnchor:   [12, 41], // point of the icon which will correspond to marker's location
    shadowAnchor: [12, 41],  // the same for the shadow
    popupAnchor:  [0, -34] // point from which the popup should open relative to the iconAnchor
});

var officeIcon = L.icon({
    iconUrl: '/assets/images/office-icon.png',
    shadowUrl: '/assets/images/marker-shadow.png',

    iconSize:     [25, 41], // size of the icon
    shadowSize:   [41, 41], // size of the shadow
    iconAnchor:   [12, 41], // point of the icon which will correspond to marker's location
    shadowAnchor: [12, 41],  // the same for the shadow
    popupAnchor:  [0, -34] // point from which the popup should open relative to the iconAnchor
});