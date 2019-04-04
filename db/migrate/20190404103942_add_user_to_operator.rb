class AddUserToOperator < ActiveRecord::Migration[5.2]
  def change
    add_reference :operators, :user, foreign_key: true
  end
end
