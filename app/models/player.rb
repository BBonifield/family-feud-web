class Player < ActiveRecord::Base
  attr_accessible :game_id, :name, :number, :phone, :score, :winner

  belongs_to :game
  has_many :guesses, :dependent => :destroy
  has_many :rounds

  after_initialize :set_defaults
  after_create :message_back

  protected

  def set_defaults
    self.score = 0 if self.score.nil?
    self.winner = false if self.winner.nil?
  end

  def message_back
    client = Twilio::REST::Client.new TWILIO_CONFIG['sid'], TWILIO_CONFIG['auth_token']
    client.account.sms.messages.create(
      :from => '+1' + TWILIO_CONFIG['incomming_phone_number'].gsub(/\-/, ''),
      :to => "+1#{self.phone}",
      :body => "You're in the game!"
    )
  end
end
