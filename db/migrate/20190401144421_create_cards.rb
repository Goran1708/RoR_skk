class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :card_number
      t.string :cvv

      t.timestamps
    end
  end
end
