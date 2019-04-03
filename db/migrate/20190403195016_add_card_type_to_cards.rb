class AddCardTypeToCards < ActiveRecord::Migration[5.2]
  def change
    add_reference :cards, :card_type, foreign_key: true
  end
end
