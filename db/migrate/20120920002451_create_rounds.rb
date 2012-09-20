class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.string :survey_text
      t.string :state
      t.integer :game_id

      t.timestamps
    end
  end
end
