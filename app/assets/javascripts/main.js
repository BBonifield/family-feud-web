(function(window, $){
  
  var app = {};

  app.init = function() {
    app.createGame();
  };

  app.createGame = function() {
    $.ajax({
      url: "/game/create",
      type: "post",
      dataType: "json",
      success: function(resp) {
        console.log(resp);
      }
    });
  };

  app.setPlayers = function(player1, player2) {


  };










  app.changeNotice = function(text) {
    var $notice = $('#notice');
    $notice.fadeOut(function(){
      $notice.html(text);
      $notice.fadeIn();
    });
  };

  window.app = app;
  $(document).ready(app.init);

})(this, jQuery);
