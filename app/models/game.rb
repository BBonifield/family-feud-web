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

    before_transition :to => Game::STATE_PLAYERS_SELECTED.to_sym, :do => :generate_players
    event :select_players do
      transition all => Game::STATE_PLAYERS_SELECTED.to_sym
    end

    before_transition :to => Game::STATE_ROUND_1.to_sym, :do => :generate_round_1
    event :begin_round_1 do
      transition all => Game::STATE_ROUND_1.to_sym
    end
    after_transition :to => Game::STATE_ROUND_1.to_sym, :do => :notify_round_start_1

    before_transition :to => Game::STATE_ROUND_2.to_sym, :do => :generate_round_2
    event :begin_round_2 do
      transition all => Game::STATE_ROUND_2.to_sym
    end
    after_transition :to => Game::STATE_ROUND_2.to_sym, :do => :notify_round_start_2

    before_transition :to => Game::STATE_ROUND_3.to_sym, :do => :generate_round_3
    event :begin_round_3 do
      transition all => Game::STATE_ROUND_3.to_sym
    end
    after_transition :to => Game::STATE_ROUND_3.to_sym, :do => :notify_round_start_3

    before_transition :to => Game::STATE_ROUND_4.to_sym, :do => :generate_round_4
    event :begin_round_4 do
      transition all => Game::STATE_ROUND_4.to_sym
    end
    after_transition :to => Game::STATE_ROUND_4.to_sym, :do => :notify_round_start_4

    before_transition :to => Game::STATE_ROUND_5.to_sym, :do => :generate_round_5
    event :begin_round_5 do
      transition all => Game::STATE_ROUND_5.to_sym
    end
    after_transition :to => Game::STATE_ROUND_5.to_sym, :do => :notify_round_start_5

    before_transition :to => Game::STATE_ROUND_6.to_sym, :do => :generate_round_6
    event :begin_round_6 do
      transition all => Game::STATE_ROUND_6.to_sym
    end
    after_transition :to => Game::STATE_ROUND_6.to_sym, :do => :notify_round_start_6

    event :end_game do
      transition all => Game::STATE_GAME_OVER.to_sym
    end

  end

  has_many :player_requests, :dependent => :destroy
  has_many :players, :dependent => :destroy
  has_many :rounds, :dependent => :destroy


  def pusher_channel
    "game_#{self.id}"
  end


  def generate_players
    selected_players = player_requests.sample(2).each_with_index do |player_request, i|
      self.players.create({
        :phone => player_request.phone,
        :name => player_request.name,
        :number => i+1
      })
    end
    Pusher[ pusher_channel ].trigger!('players_selected', self.players)
  end

  def notify_round_start_1
    notify_round_start 1
  end
  def notify_round_start_2
    notify_round_start 2
  end
  def notify_round_start_3
    notify_round_start 3
  end
  def notify_round_start_4
    notify_round_start 4
  end
  def notify_round_start_5
    notify_round_start 5
  end
  def notify_round_start_6
    notify_round_start 6
  end
  def notify_round_start number
    Pusher[ pusher_channel ].trigger!('round_started', self.rounds.last)
  end

  def generate_round_1
    generate_round 1
  end
  def generate_round_2
    generate_round 2
  end
  def generate_round_3
    generate_round 3
  end
  def generate_round_4
    generate_round 4
  end
  def generate_round_5
    generate_round 5
  end
  def generate_round_6
    generate_round 6
  end
  def generate_round number
    if number == 1
      player = self.players.find_by_number 1
    else
      previous_player = self.rounds.last.player
      new_player_number = previous_player.number == 1 ? 2 : 1

      player = self.players.find_by_number new_player_number
    end

    self.rounds.create :number => number, :player => player
  end

end
