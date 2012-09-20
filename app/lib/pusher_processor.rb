class PusherProcessor

  attr_accessor :payload

  def initialize incomming_payload
    @payload = incomming_payload
  end

  def process
    # ignore if no active game
    if active_game

      case active_game.state
      when Game::STATE_AWAITING_PLAYERS
        active_game.select_players
      when Game::STATE_PLAYERS_SELECTED
        active_game.begin_round_1
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

  def process_round round_number
    round = active_game.rounds.find_by_number round_number

    if round

      case round.state
      when Round::STATE_AWAITING_ENTRIES
        round.sum_entries
      when Round::STATE_GUESS_1
        round.await_guess_2
      when Round::STATE_GUESS_2
        round.await_guess_3
      when Round::STATE_GUESS_3
        round.await_guess_4
      when Round::STATE_GUESS_4
        round.await_guess_5
      when Round::STATE_GUESS_5
        round.end_round
      when Round::STATE_COMPLETE
        # no action
      end

    end
  end

  def active_game
    if @active_game.nil?
      @active_game = Game.where("state != ?", Game::STATE_GAME_OVER).last
    end

    @active_game
  end
end
