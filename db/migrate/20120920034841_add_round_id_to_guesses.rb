class AddRoundIdToGuesses < ActiveRecord::Migration
  def change
    add_column :guesses, :round_id, :integer
  end
end
