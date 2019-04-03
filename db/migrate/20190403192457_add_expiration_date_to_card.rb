class AddExpirationDateToCard < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :expiration_date, :date_time
  end
end
