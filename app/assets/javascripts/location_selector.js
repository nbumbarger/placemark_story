// Sets up custom Mapbox map control and form interactions, used in the
// placemark entry view to find geocoded addresses, visually represent 
// coordinates, set coordinates interactively, and reload saved location data.

function initLocationSelector(mapboxToken) {

  L.mapbox.accessToken = mapboxToken;
  // Define map control, adding it to map div.
  var map = L.mapbox.map('map', 'mapbox.streets');

  // Define geocoder control
  var gc = L.mapbox.geocoderControl('mapbox.places',
    { position: 'topright', 
      keepOpen: false })
    // Add event listener to re-center marker when geocoder finds address
    .on('found', function(res) {
      moveMarkerToGCResponse(res)})
    // Attach the geocoder to the map
    .addTo(map)
    
  // Define draggable marker
  var marker = L.marker([0, 0],
    { icon: L.mapbox.marker.icon({'marker-color': '#f86767'}),
      draggable: true })
    // Add event listener to record marker position on form when marker is moved
    .on('dragend', recordMarkerPosition)
    // Add marker to map
    .addTo(map);

  // Center draggable marker at found location after using geocoder
  function moveMarkerToGCResponse(res) {
    coords = res.results.features[0].center
    marker.setLatLng({lat: coords[1], lng: coords[0]});
    recordMarkerPosition();
  }

  // Store marker coordinates in form, and update coordinate legend
  function recordMarkerPosition() {
    var coords = marker.getLatLng();
    $('#placemark_lat').val(coords.lat);
    $('#placemark_lng').val(coords.lng);
    updateCoordsLegend(coords);
  };

  // Update coordinate legend
  function updateCoordsLegend(coords) {
    coordinates.innerHTML = 'Coordinates:<br />Lat: ' 
                          + Number((coords.lat).toFixed(3))
                          + '<br />Lon: ' + Number((coords.lng).toFixed(3));
  };

  // Update map view and marker position based on existing form data
  function loadSavedMapParameters() {
    savedCoords = {lat: $('#placemark_lat').val(), lng: $('#placemark_lng').val()}
    if(savedCoords.lat !== '' && savedCoords.lng !== '') {
      marker.setLatLng({lat: savedCoords.lat, lng: savedCoords.lng});
      map.setView([savedCoords.lat, savedCoords.lng], 13);
      updateCoordsLegend(marker.getLatLng());
    };
  };

  // Update map view based on existing form data
  loadSavedMapParameters();

};