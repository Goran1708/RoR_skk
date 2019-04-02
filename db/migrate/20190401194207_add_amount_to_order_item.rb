class AddAmountToOrderItem < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :amount, :integer, :default => 1
  end
end
