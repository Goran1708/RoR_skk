class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.string :destination
      t.datetime :departure
      t.datetime :arrival

      t.timestamps
    end
  end
end
