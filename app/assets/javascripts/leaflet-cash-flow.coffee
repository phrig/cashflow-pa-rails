$ ->
  defaultIcon = L.icon({ iconUrl: 'assets/icon-yellow.png' })
  L.gridLayer.googleMutant(type: 'roadmap').addTo(map)
  markers = L.markerClusterGroup()
  markerData.forEach (markerPoint)->
    marker = L.marker(markerPoint.latlng, {icon: defaultIcon}).bindPopup(markerPoint.popup)
    markers.addLayer(marker)
  map.fitBounds(bounds)
  map.addLayer(markers)
