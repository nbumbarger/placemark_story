// Sets up the Mapbox-driven story map display, including
// table of contents and informational popups.

function initStoryMap(mapboxToken, placemarkJSON) {

  L.mapbox.accessToken = mapboxToken;
  // Initialize map frame with default zoom behavior disabled
  var map = L.mapbox.map('map', 'mapbox.streets', {doubleClickZoom: false})
    // Add custom zoom behavior (pan to center of double-click event)
    .on('dblclick', function(e) {
      map.setView(e.latlng, map.getZoom() + 1)
    });
  // Add empty feature layer to map frame
  var featureLayer = L.mapbox.featureLayer().addTo(map)

  // Build the map and table of contents
  loadFeatures()
  addZoomOnClick()
  addPopups()

  // Load features from GeoJSON server
  function loadFeatures() {
    $.ajax({
      type: 'GET',
      dataType: 'json',
      url: placemarkJSON})
    .done(function (geojson) { 
      // Load response GeoJSON into feature layer
      featureLayer.setGeoJSON(geojson);
      // Fit map to bounding coordinates of features, then zoom out a bit
      map.fitBounds(featureLayer.getBounds());
      // Todo: may want to add logic to zoom out one step, if the fitted view is extremely tight around the placemarks
      // map.setZoom(map.getZoom() - 1)
      // Build Table of Contents as features are loaded
      buildTableOfContents();
    });
  };

  // Add a listening event to each feature, to pan when clicked
  function addZoomOnClick() {
    featureLayer.on('click', function(e) {
      map.setView(e.layer.getLatLng(), map.getZoom() + 1);
      // Todo: add logic to offset the map center when the popup content is too large to fit in screen
      // map.panBy([110, -75])
    })
  };

  // Add custom HTML popups to each feature
  function addPopups() {
    featureLayer.on('layeradd', function(e) {
      var marker = e.layer;
      var feature = marker.feature;
      // Write popup HTML
      var content = '';
      var name = feature.properties.name;
      var description = feature.properties.description;
      var image = feature.properties.image;
      var link = feature.properties.link;
      content = content + '<h2>'+name+'</h2>'
      if (image !== '') {
        content = content + '<img src="'+image+'" alt="'+feature.properties.image_alt+'" />'};
      if (description !== '') {
          content = content + '<p>'+description+'</p>'};
      if (link !== '') {
          content = content + '<div class="truncate"><a href="'+link+'">'+link+'</a></div>'};
        marker.bindPopup(content, {
          closeButton: false
        });
    });
  };

  // For each feature, add an entry to the marker list, including the feature name and a click event which zooms to the feature's coordinates
  function buildTableOfContents() {
    var markerList = document.getElementById('marker-list');
    featureLayer.eachLayer(function(layer) {
      var item = markerList.appendChild(document.createElement('li'));
      item.innerHTML = layer.toGeoJSON().properties.name;
      item.onclick = function() {
        map.setView(layer.getLatLng());
        // Todo: add logic to only offset the map center when the popup content is too large to fit in screen
        // map.panBy([110, -75])
        layer.openPopup();
      };
    });
  };

};