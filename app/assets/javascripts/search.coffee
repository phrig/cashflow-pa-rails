@checkLocationError = (locationError) ->
  if locationError['error'] == false
    return
  else
    $('#locationErrorModal').modal('show');
  return
