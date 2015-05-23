// Defines parameters for image cropping library, and sets up click, 
// load and submission events to integrate its functionality with 
// that of the placemark entry form.

function initImageUploader() {

  // Initialize image upload widget
  var imageEditor = $('.image-editor')
  imageEditor.cropit({
    exportZoom: 3,
    // Set image to form data
    imageState: {src: $('#placemark_image_data').val()},
    // On file change, set alt text to image name
    onFileChange: function() {
      var imagePath = $('.cropit-image-input').val()
      $('.image-alt').val(imagePath.substring(imagePath.lastIndexOf('\\')+1, imagePath.lastIndexOf('.')));
    }
  });

  // Set image alt to form data
  $('.image-alt').val($('#placemark_image_alt').val())

  // Process and save image on form submission  
  $('form').submit(function(event) {
  // Compress and crop image
    var imageData = imageEditor.cropit('export',
      {type: 'image/jpeg',
       quality: .9,
       originalSize: false}
    );
    // Move cropped image data and image metadata to hidden fields
    var imageAlt = $('.image-alt').val();
    $('#placemark_image_data').val(imageData);
    $('#placemark_image_alt').val(imageAlt);
  });

  // On click of select_image button, simulate click of hidden file input widget
  $('.select-image-button').click(function() {
    $('.cropit-image-input').click();
  });

};