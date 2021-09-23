class CreateTransactionDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :transaction_details do |t|
      t.integer :quantily
      t.decimal :price
      t.references :transaction, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
