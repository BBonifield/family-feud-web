(function(window, $){
  
  var app = {};

  app.init = function() {
    app.createGame();
  };

  app.createGame = function() {
    $.ajax({
      url: "/games/create",
      type: "get",
      dataType: "json",
      success: function(resp) {
        console.log(resp);
        app.changeStateNotice(resp.state);
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

  app.changeStateNotice = function(state) {
    var $state_notice = $('#state_notice');
    $state_notice.fadeOut(function(){
      $state_notice.html(state);
      $state_notice.fadeIn();
    });
  };

  window.app = app;
  $(document).ready(app.init);

})(this, jQuery);
