class Game < ActiveRecord::Base
  attr_accessible :state

  has_many :player_requests, :dependent => :destroy
  has_many :players, :dependent => :destroy
  has_many :rounds, :dependent => :destroy
end
