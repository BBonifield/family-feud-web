class PlayerRequest < ActiveRecord::Base
  attr_accessible :game_id, :name, :phone

  belongs_to :game
end
