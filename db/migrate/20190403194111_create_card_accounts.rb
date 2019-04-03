class CreateCardAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :card_accounts do |t|
      t.references :card, foreign_key: true
      t.integer :balance

      t.timestamps
    end
  end
end
