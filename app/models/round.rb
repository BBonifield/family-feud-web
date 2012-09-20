class Round < ActiveRecord::Base
  STATE_AWAITING_ENTRIES = "awaiting_entries"
  STATE_GUESS_1 = "guess_1"
  STATE_GUESS_2 = "guess_2"
  STATE_GUESS_3 = "guess_3"
  STATE_GUESS_4 = "guess_4"
  STATE_GUESS_5 = "guess_5"
  STATE_COMPLETE = "complete"

  before_create :set_survey_text

  attr_accessible :game_id, :player_id, :state, :survey_text, :number

  state_machine :state, :initial => Round::STATE_AWAITING_ENTRIES.to_sym do

    event :sum_entries do
      transition all => Round::STATE_GUESS_1.to_sym
    end

    event :await_guess_2 do
      transition all => Round::STATE_GUESS_2.to_sym
    end
    event :await_guess_3 do
      transition all => Round::STATE_GUESS_3.to_sym
    end
    event :await_guess_4 do
      transition all => Round::STATE_GUESS_4.to_sym
    end
    event :await_guess_5 do
      transition all => Round::STATE_GUESS_5.to_sym
    end
    event :end_round do
      transition all => Round::STATE_COMPLETE.to_sym
    end

    event :force_round_end do
      transition all => Round::STATE_COMPLETE.to_sym
    end

  end

  def set_survey_text
    f = open "#{Rails.root}/app/lib/surveys.txt"
    c = f.read
    f.close
    surveys = c.split "\n"
    self.survey_text = surveys.sample
  end

  belongs_to :game
  belongs_to :player
  has_many :entries, :dependent => :destroy
  has_many :totals, :dependent => :destroy
end
