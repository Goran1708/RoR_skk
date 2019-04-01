class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.references :purchase_history, foreign_key: true
      t.references :ticket, foreign_key: true

      t.timestamps
    end
  end
end
