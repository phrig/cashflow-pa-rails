$ ->
  defaultIcon = L.icon({ iconUrl: 'assets/icon-yellow.png' })
  L.gridLayer.googleMutant(type: 'roadmap').addTo(map)
  markerData.forEach (markerPoint)->
    marker = L.marker(markerPoint.latlng, {icon: defaultIcon}).bindPopup(markerPoint.popup)
    map.addLayer(marker)

  map.fitBounds(bounds)