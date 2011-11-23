$(window).bind('mercury:ready', function() {
  var link = $('#mercury_iframe').contents().find('#edit_link');
  Mercury.saveURL = link.data('save-url');
  link.hide();
});

$(window).bind('mercury:saved', function() {
  window.location = window.location.href.replace(/\/editor\//i, '/admin/');
});
