(function(window, $){
  
  var app = {};

  app.init = function() {
    console.log('hi');
  };

  window.app = app;
  $(document).ready(app.init);

})(this, jQuery);
