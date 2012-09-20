class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :text
      t.string :phone
      t.integer :round_id

      t.timestamps
    end
  end
end
