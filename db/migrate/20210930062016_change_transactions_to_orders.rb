class ChangeTransactionsToOrders < ActiveRecord::Migration[6.1]
  def change
    rename_table :transactions, :orders
  end
end
