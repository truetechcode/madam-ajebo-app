class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :amount
      t.string :origin_currency
      t.string :destination_currency
      t.string :txn_id
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
