class AddPlayerIdToRounds < ActiveRecord::Migration
  def change
    add_column :rounds, :player_id, :integer
  end
end
