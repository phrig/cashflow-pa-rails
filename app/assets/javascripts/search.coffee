@checkLocationError = (locationError) ->
  if locationError['error'] == false
    return
  else
    $('#locationErrorModal').modal('show');
  return

@triggerPopup = (latlng, popup) ->
  p = L.popup({offset: [0,-27]}).setLatLng(latlng).setContent(popup).openOn(map)
  return
