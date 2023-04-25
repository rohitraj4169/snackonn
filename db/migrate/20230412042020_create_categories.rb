class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.string :image
      t.references :parent_category, foreign_key: { to_table: :categories }

      t.timestamps
    end
    add_index :categories, :name
  end
end
