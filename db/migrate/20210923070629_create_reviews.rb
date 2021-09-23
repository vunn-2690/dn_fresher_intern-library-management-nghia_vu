class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :name
      t.string :email
      t.text :content
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
