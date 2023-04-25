class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.json :order_items
      t.integer :sub_total

      t.timestamps
    end
  end
end
