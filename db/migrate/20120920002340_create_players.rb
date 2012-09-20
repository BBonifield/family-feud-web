class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :phone
      t.string :name
      t.integer :number
      t.boolean :winner
      t.integer :score
      t.integer :game_id

      t.timestamps
    end
  end
end
