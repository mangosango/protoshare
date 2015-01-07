$( document ).ready(function() {
  var $description = $('#description');
  var $overlay = $description.find('.overlay');
  var $content = $description.find('.content');
  var pad = 25
  var toggled = false;

  $description.on('click', function() {
    if (toggled) {
      $(this).velocity("reverse");
      $overlay.velocity({ top: 0, opacity: 1 }, { visibility: "visible", delay: 200 }, 300, [ .79, 0, .28, 1 ]);
      toggled = false;
    } else {
      $(this).velocity({ height: $content.height()+pad, maxHeight: $content.height() + 5000 }, 300, [ .79, 0, .28, 1 ]);
      $overlay.velocity({ top: $content.height(), opacity: 0 }, { visibility: "hidden" }, 300, [ .79, 0, .28, 1 ]);
      toggled = true;
    }
  });  
});