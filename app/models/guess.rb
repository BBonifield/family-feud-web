class Guess < ActiveRecord::Base
  attr_accessible :player_id, :text

  belongs_to :player
end
