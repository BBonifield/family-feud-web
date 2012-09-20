class AddRoundNumberToRounds < ActiveRecord::Migration
  def change
    add_column :rounds, :number, :integer
  end
end
