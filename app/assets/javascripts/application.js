// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
$(document).ready(function() {
  $("#save-image").on("click", function(){
    var canvas = document.getElementById("canvas");
    var data = canvas.toDataURL('image/jpeg');
    // var blob = dataURItoBlob(data);
    var fd = new FormData();
    fd.append("canvasImage", data);
    console.log(fd)
    $.ajax({
   url: "/save_that_stache",
   type: "POST",
   data: fd,
   processData: false,
   contentType: false,
})
  })

})

function dataURLtoBlob(dataURL) {
    // Decode the dataURL
    var binary = atob(dataURL.split(',')[1]);
    // Create 8-bit unsigned array
    var array = [];
    for(var i = 0; i < binary.length; i++) {
        array.push(binary.charCodeAt(i));
    }
    // Return our Blob object
    return new Blob([new Uint8Array(array)], {type: 'image/png'});
  }

// function dataURItoBlob(dataURI) {
// // convert base64/URLEncoded data component to raw binary data held in a string
// var byteString;
// if (dataURI.split(',')[0].indexOf('base64') >= 0)
// byteString = atob(dataURI.split(',')[1]);
// else
// byteString = unescape(dataURI.split(',')[1]);
//
// // separate out the mime component
// var mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0];
//
// // write the bytes of the string to a typed array
// var ia = new Uint8Array(byteString.length);
// for (var i = 0; i < byteString.length; i++) {
// ia[i] = byteString.charCodeAt(i);
// }
//
// return new Blob([ia], {type:mimeString});
// }
