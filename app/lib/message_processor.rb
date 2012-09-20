class MessageProcessor

  attr_accessor :payload

  def initialize incomming_payload
    @payload = incomming_payload
  end

  def process
    # ignore if no active game
    if active_game

      case active_game.state
      when Game::STATE_AWAITING_PLAYERS
        create_player_request
      when Game::STATE_PLAYERS_SELECTED
        # no action
      when Game::STATE_ROUND_1
        process_round 1
      when Game::STATE_ROUND_2
        process_round 2
      when Game::STATE_ROUND_3
        process_round 3
      when Game::STATE_ROUND_4
        process_round 4
      when Game::STATE_ROUND_5
        process_round 5
      when Game::STATE_ROUND_6
        process_round 6
      end

    end
  end

  protected

  def create_player_request
    active_game.player_requests.create :name => payload[:text], :phone => payload[:from]
  end

  def process_round round_number
    round = active_game.rounds.find_by_number round_number

    if round

      case round.state
      when Round::STATE_AWAITING_ENTRIES
        # track the entry for summation
        round.entries.create :text => payload[:text], :phone => payload[:from]
      when Round::STATE_GUESS_1
        process_guess round, 1
      when Round::STATE_GUESS_2
        process_guess round, 2
      when Round::STATE_GUESS_3
        process_guess round, 3
      when Round::STATE_GUESS_4
        process_guess round, 4
      when Round::STATE_GUESS_5
        process_guess round, 5
      when Round::STATE_COMPLETE
        # no action
      end

    end
  end

  def process_guess round, guess_number
    linked_player = active_game.players.find_by_phone payload[:from]

    # ensure that we only accept guesses from the proper player
    if linked_player && round.player == linked_player
      round.player.guesses.create :text => payload[:text]
    end
  end

  def active_game
    if @active_game.nil?
      @active_game = Game.where("state != ?", Game::STATE_GAME_OVER).last
    end

    @active_game
  end
end
