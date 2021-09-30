class ChangeSomeName < ActiveRecord::Migration[6.1]
  def change
    rename_column :order_details, :transaction_id, :order_id
  end
end
