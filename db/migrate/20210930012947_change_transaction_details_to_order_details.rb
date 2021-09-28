class ChangeTransactionDetailsToOrderDetails < ActiveRecord::Migration[6.1]
  def change
    rename_table :transaction_details, :order_details
  end
end
