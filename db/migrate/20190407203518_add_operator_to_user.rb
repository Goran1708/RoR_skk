class AddOperatorToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :operator, foreign_key: true
  end
end
