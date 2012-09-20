(function(window, $){
  
  var app = {};

  app.game_channel = null;

  app.init = function() {
    app.createGame();
    app.fadeStateNotice();
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

  app.startRound = function(data) {
    var question = "Question " + data.number + ": " + data.survey_text;
    app.changeNotice(question);
    app.changeStateNotice(data.state);
  };

  app.totalsAvailable = function(data) {
    app.changeStateNotice("awaiting_player_guess");
  };

  app.guessReceived = function(data) {
    if (data.correct) {
      var $score = $('#player'+data.player.number).find('.score').text(data.player.score);
      app.display('GOOD GUESS');
    } else {
      app.display('NOPE');
    }
  };

  app.display = function(text) {
    var $answer = $('#answer');
    $answer.text(text);
    $answer.fadeIn(function(){
      setTimeout(function(){ $answer.fadeOut(5000); }, 3000);
    });
  };

  app.createChannel = function(id) {
    var pusher = new Pusher(window.pusher_key); // Replace with your app key
    var channel = pusher.subscribe('game_' + id);
    app.game_channel = channel;

    channel.bind('players_selected', app.setPlayers);
    channel.bind('round_started', app.startRound);
    channel.bind('totals_available', app.totalsAvailable);
    channel.bind('guess_received', app.guessReceived);

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

  app.fadeStateNotice = function() {
    var $state_notice = $('#state_notice');
    var speed = 800;
    $state_notice.fadeOut(speed, function(){
      $state_notice.fadeIn(speed, app.fadeStateNotice);
    });
  };

  window.app = app;
  $(document).ready(app.init);

})(this, jQuery);
