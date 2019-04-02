class AddTotalToOrderItem < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :total, :integer
  end
end
