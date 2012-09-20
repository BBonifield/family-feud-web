class Entry < ActiveRecord::Base
  attr_accessible :phone, :round_id, :text

  belongs_to :round
end
