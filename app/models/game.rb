class Game < ActiveRecord::Base
  STATE_AWAITING_PLAYERS = "awaiting_players"
  STATE_PLAYERS_SELECTED = "players_selected"
  STATE_ROUND_1 = "round_1"
  STATE_ROUND_2 = "round_2"
  STATE_ROUND_3 = "round_3"
  STATE_ROUND_4 = "round_4"
  STATE_ROUND_5 = "round_5"
  STATE_ROUND_6 = "round_6"
  STATE_GAME_OVER = "game_over"

  attr_accessible :state

  state_machine :state, :initial => Game::STATE_AWAITING_PLAYERS.to_sym do

    event :select_players do
      transition all => Game::STATE_PLAYERS_SELECTED.to_sym
    end

    event :begin_round_1 do
      transition all => Game::STATE_ROUND_1.to_sym
    end
    event :begin_round_2 do
      transition all => Game::STATE_ROUND_2.to_sym
    end
    event :begin_round_3 do
      transition all => Game::STATE_ROUND_3.to_sym
    end
    event :begin_round_4 do
      transition all => Game::STATE_ROUND_4.to_sym
    end
    event :begin_round_5 do
      transition all => Game::STATE_ROUND_5.to_sym
    end
    event :begin_round_6 do
      transition all => Game::STATE_ROUND_6.to_sym
    end

    event :end_game do
      transition all => Game::STATE_GAME_OVER.to_sym
    end

  end

  has_many :player_requests, :dependent => :destroy
  has_many :players, :dependent => :destroy
  has_many :rounds, :dependent => :destroy
end
