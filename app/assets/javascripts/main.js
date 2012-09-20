(function(window, $){
  
  var app = {};

  app.game_channel = null;

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
        app.createChannel(resp.id);
      }
    });
  };

  app.setPlayers = function(data) {
    var player_info = "";

    $.each(data, function(i, player) {
      $('#player'+ (i+1)).find('.name').text(player.name);
      player_info += "<br/>" + player.name + " - (" + player.phone + ")";
    });

    app.changeNotice('Players have been selected! <br/>' + player_info + '<br/><br/>Please step up to the front!');
    app.changeStateNotice('players_selected');
  };

  app.createChannel = function(id) {
    var pusher = new Pusher(window.pusher_key); // Replace with your app key
    var channel = pusher.subscribe('game_' + id);
    app.game_channel = channel;

    channel.bind('players_selected', app.setPlayers);

    channel.bind_all(function(data) {
      console.log(arguments)
    });
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
