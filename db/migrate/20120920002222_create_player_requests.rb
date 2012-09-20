class CreatePlayerRequests < ActiveRecord::Migration
  def change
    create_table :player_requests do |t|
      t.string :phone
      t.string :name
      t.integer :game_id

      t.timestamps
    end
  end
end
