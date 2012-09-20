class Player < ActiveRecord::Base
  attr_accessible :game_id, :name, :number, :phone, :score, :winner

  belongs_to :game
  has_many :guesses, :dependent => :destroy
  has_many :rounds

  after_initialize :set_defaults

  protected

  def set_defaults
    self.score = 0 if self.score.nil?
    self.winner = false if self.winner.nil?
  end
end
