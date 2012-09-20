class Total < ActiveRecord::Base
  attr_accessible :entry_sum, :round_id, :text, :taken

  belongs_to :round

  after_initialize :set_defaults

  def set_defaults
    self.taken = false if self.taken.nil?
  end
end
