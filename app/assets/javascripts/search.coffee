@checkLocationError = (locationError) ->
  if locationError['error'] == false
    return
  else
    $('#locationErrorModal').modal 'show'
  return

@triggerPopup = (latlng, popup) ->
  p = undefined
  p = L.popup().setLatLng(latlng).setContent(popup).openOn(map)
  map.panTo(latlng)
  return
