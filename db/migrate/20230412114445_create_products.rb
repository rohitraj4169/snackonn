class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.float :weight
      t.integer :stock
      t.string :unit
      t.boolean :status
      t.string :image
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
