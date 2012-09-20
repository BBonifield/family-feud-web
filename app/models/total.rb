class Total < ActiveRecord::Base
  attr_accessible :entry_sum, :round_id, :text

  belongs_to :round
end
