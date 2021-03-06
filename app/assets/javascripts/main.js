function main(mapboxToken) {

  // ---------------------------------------------------------------------
  // BEGIN uploader functions --------------------------------------------
  // ---------------------------------------------------------------------
  // Define parameters for image cropping library; set up image-related 
  // load and submission events; set up GPS-metadata extraction logic;
  // set up form and map interactions

  function initUploader() {
    // Initialize image upload widget
    var uploader = $('.image-editor')
    uploader.cropit({
      // Exported image set to 3x the preview's size
      exportZoom: 3,
      // Set initial image to saved data, if applicable
      imageState: {src: $('#placemark_image_data').val()},
      // When image is loaded:
      onImageLoaded: function() {
        // Set image alt text to image name;
        var imagePath = $('.cropit-image-input').val();
        $('.image-alt').val(imagePath.substring(imagePath.lastIndexOf('\\')+1, imagePath.lastIndexOf('.')));
        // Attempt to set location based on coordinate metadata
        setExifLocation();
      }
    });
    // Return uploader to caller's scope
    return uploader;
  };

  function setExifLocation() {
    // Load image from base64 data
    var image = new Image();
    image.onload = function() {
      // Read EXIF data from image
      EXIF.getData(image, function() {
        // Attempt to extract GPS coordinate information from EXIF data
        var lngAry = EXIF.getTag(this, 'GPSLongitude');
        var latAry = EXIF.getTag(this, 'GPSLatitude');
        var lngRef = EXIF.getTag(this, 'GPSLongitudeRef');
        var latRef = EXIF.getTag(this, 'GPSLatitudeRef');
        // If GPS metadata is valid...
        if (typeof lngAry != 'undefined' && typeof latAry != 'undefined') {
          // Convert coordinate information to decimal degrees;
          var lngDec = convertExifCoordData(lngAry, lngRef);
          var latDec = convertExifCoordData(latAry, latRef);
          // Update all location attributes using GPS metadata
          updateLocation(latDec, lngDec, 0, 0, 15)
        };
      });
    };
    image.src = uploader.cropit('imageSrc')
  };

  function convertExifCoordData(coordAry, hemisphere) {
    // Convert coordinate arrays to degrees, minutes, seconds
    var degree = coordAry[0].numerator;
    var minute = coordAry[1].numerator / coordAry[1].denominator;
    var second = coordAry[2].numerator / coordAry[2].denominator;
    // Convert DMS to decimal degrees
    var decimalDegrees = degree + (minute / 60) + (second / 3600);
    // Extract hemisphere ID from binary data
    hemisphere = hemisphere.charAt(0);
    // Return negative decimals if W or S hemisphere, positive if E or W
    if (hemisphere === 'W' || hemisphere === 'S') {
      return -decimalDegrees;
    } else {
      return decimalDegrees;
    };
  };

  function submitImageData() {
    // Compress and crop image
    var imageData = uploader.cropit('export',
      { type: 'image/jpeg',
        quality: .9,
        originalSize: false } );
    // Move cropped image data to hidden fields for submission
    $('#placemark_image_data').val(imageData);
    $('#placemark_image_alt').val($('.image-alt').val());
  };
  // ---------------------------------------------------------------------
  // END uploader functions ----------------------------------------------
  // ---------------------------------------------------------------------

  // -------------------------------------------------------------- -------
  // BEGIN map functions -------------------------------------------------
  // ---------------------------------------------------------------------
  // Set up Mapbox map, geocoder, position reticule, and location control;
  // define location set and display callbacks; set up form interactions

  function initMap() {
    // Check out the Mapbox API
    L.mapbox.accessToken = mapboxToken;
    // Initialize map frame centered on Washington DC area
    var map = L.mapbox.map('map', 'mapbox.streets', {doubleClickZoom: false})
      .setView([38.895, -77.036], 5)
      // Map callback: Pan and zoom to location of double-click
      .on('dblclick', function(evt) {
        map.setView(evt.latlng, map.getZoom() + 1);
      });
    // Initialize the geocoder control
    var gc = L.mapbox.geocoderControl('mapbox.places', {
      position: 'topright',
      keepOpen: false })
      // GC Callback: automatically update map using first geocoder result
      .on('found', function(evt) {
        coords = evt.results.features[0].center;
        updateLocation(coords[1], coords[0], 0, 0.0025, 15)
      })
      // GC Callback: update map using selected geocoder result
      .on('select', function(evt) {
        coords = evt.feature.geometry.coordinates;
        updateLocation(coords[1], coords[0], 0, 0.0025, 15)
      })
      // Attach the geocoder to the map
      .addTo(map);
    // Initialize the leaflet user location control
    var lc = L.control.locate( {
      position: 'topright',
      locateOptions: {maxZoom: 17},
      strings: {title: "Use current location"} })
      // Attach the location control to the map
      .addTo(map);
      // Location Callback: update cordinate and marker to user position
      map.on('locationfound', function(evt) {
        coords = evt.latlng;
        updateMarkerPosition(coords.lat, coords.lng);
        updateCoordinateData(coords.lat, coords.lng);
      });
      // Location Callback: Stop following when map is panned
      map.on('dragstart', lc._stopFollowing, lc);
    // Return map to caller's scope
    return map;
  };

  function initMarker() {
    // Define interactive location marker
    var marker = L.marker([38.895, -77.036],
      { icon: L.mapbox.marker.icon({'marker-color': '#f86767'}),
        draggable: true })
      // Marker Callback: Update coordinate data when marker is manually moved
      .on('dragend', function(evt) {
        coords = evt.target._latlng;
        updateCoordinateData(coords.lat, coords.lng);
      })
      // Add the marker to the map
      .addTo(map);
    // Return marker to caller's scope
    return marker;
  };

  function updateMapView(lat, lng, y_offset, x_offset, zoom) {
    // Center map view on lat/lng
    map.setView([lat+y_offset, lng+x_offset], zoom);
  }

  function updateMarkerPosition(lat, lng) {
    // Center marker on lat/lng
    marker.setLatLng([lat, lng]);
  }

  function updateCoordinateData(lat, lng) {
    // Update the coordinate legend
    coordinates.innerHTML = 'Coordinates:<br />Lat: '
                          + Number(lat).toFixed(3)
                          + '<br />Lon: ' + Number(lng).toFixed(3);
    // Copy coordinate data to hidden form fields
    $('#placemark_lat').val(lat);
    $('#placemark_lng').val(lng);
  }

  // Update all spatial attributes (view, marker, legend, form)
  function updateLocation(lat, lng, map_y_offset, map_x_offset, map_zoom) {
    updateMarkerPosition(lat, lng);
    updateMapView(lat, lng, map_y_offset, map_x_offset, map_zoom);
    updateCoordinateData(lat, lng);
  };
  // ---------------------------------------------------------------------
  // END map functions ---------------------------------------------------
  // ---------------------------------------------------------------------

  // Intitialize shared functions in global scope (uploader, map, map marker)
  var uploader = initUploader();
  var map = initMap();
  var marker = initMarker();

  // Set image alt to existing form data;
  $('.image-alt').val($('#placemark_image_alt').val());
  // Update location attributes based on existing form data
  var lat = $('#placemark_lat').val();
  var lng = $('#placemark_lng').val();
  if (lat !== '' && lng !== '') {
    updateLocation(lat, lng, 0, 0, 15);
  };

  // Document Callback: Activate file input control on click of select-image-button.
  $('.select-image-button').click(function() {
    $('.cropit-image-input').click();
  });

  // Document Callback: When form is submitted, add image data to hidden fields
  $('form').submit(function(event) {
    submitImageData();
  });

};