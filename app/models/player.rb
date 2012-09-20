class Player < ActiveRecord::Base
  attr_accessible :game_id, :name, :number, :phone, :score, :winner

  belongs_to :game
  has_many :guesses, :dependent => :destroy
end
