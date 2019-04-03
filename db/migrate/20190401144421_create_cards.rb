class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :card_number_digest
      t.string :cvv_digest

      t.timestamps
    end
  end
end
