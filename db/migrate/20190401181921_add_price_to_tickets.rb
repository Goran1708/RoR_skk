class AddPriceToTickets < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :price, :decimal
  end
end
