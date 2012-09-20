class CreateTotals < ActiveRecord::Migration
  def change
    create_table :totals do |t|
      t.string :text
      t.integer :entry_sum
      t.integer :round_id

      t.timestamps
    end
  end
end
