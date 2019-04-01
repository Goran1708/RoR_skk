class AddTicketToOperator < ActiveRecord::Migration[5.2]
  def change
    add_reference :tickets, :operator, foreign_key: true
  end
end
