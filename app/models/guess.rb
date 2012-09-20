class Guess < ActiveRecord::Base
  attr_accessible :player_id, :round_id, :text

  belongs_to :player
  belongs_to :round

  after_create :handle_score_update

  def handle_score_update
    total = self.round.totals.where( "text = ? AND taken = ?", self.text, false ).first
    if total
      self.round.player.update_attribute :score, self.round.player.score + total.entry_sum
      correct = true
    else
      correct = false
    end

    Pusher[ self.round.game.pusher_channel ].trigger!('guess_received', { :player => self.round.player, :guess => self, :correct => correct } )
  end
end
