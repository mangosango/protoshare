// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.turbolinks
//= require turbolinks
//= require foundation
//= require jquery_nested_form
//= require_tree .

$(function() {
  var names = [];
  if ( $('#attachments_') ) {
    console.debug('attachmeants attached')
    $('#attachments_').change(function(e) {
      var files = e.target.files; // FileList
      names = [];
      for (var i = 0, f; f = files[i]; ++i){
        // console.debug(files[i].webkitRelativePath);
        names.push( files[i].webkitRelativePath.replace(files[i].name,'') );
      }
      console.debug(names);
      $('#filename_').val(names);
    });
  }

  // $('input[name="commit"]').on('click', function(e) {
  //   e.preventDefault();
  //   $.post( "/prototypes", {
  //     'files[]': $('#attachments_').val(),
  //     'names[]': names
  //   } );
  // })

  $(document).foundation();
});