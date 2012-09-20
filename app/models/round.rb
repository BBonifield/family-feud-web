class Round < ActiveRecord::Base
  attr_accessible :game_id, :state, :survey_text

  belongs_to :game
  has_many :entries, :dependent => :destroy
  has_many :totals, :dependent => :destroy
end
