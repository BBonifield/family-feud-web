class StateProcessor

  attr_accessor :active_game

  def initialize use_game
    @active_game = use_game
  end

  def advance
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
        if round.number == 6
          active_game.end_game
        else
          method = "begin_round_#{round.number+1}"
          active_game.send method.to_sym
        end
        # no action
      end

    end
  end
end
