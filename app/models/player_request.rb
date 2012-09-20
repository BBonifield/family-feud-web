class PlayerRequest < ActiveRecord::Base
  attr_accessible :game_id, :name, :phone

  belongs_to :game

  validates_uniqueness_of :phone, :scope => :game_id
end
