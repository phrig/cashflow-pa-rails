$ ->
  L.gridLayer.googleMutant(type: 'roadmap').addTo(map)
  markerData.forEach (markerPoint)->
    console.log(markerPoint.latlng)
    marker = L.marker(markerPoint.latlng).bindPopup(markerPoint.popup)
    map.addLayer(marker)

  map.fitBounds(bounds)