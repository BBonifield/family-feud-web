class AddEntryIdToGuesses < ActiveRecord::Migration
  def change
    add_column :guesses, :entry_id, :integer
  end
end
