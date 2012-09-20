class AddTakenToTotals < ActiveRecord::Migration
  def change
    add_column :totals, :taken, :boolean
  end
end
