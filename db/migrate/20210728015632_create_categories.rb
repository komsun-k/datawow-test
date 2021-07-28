class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.integer :first_level_cat_id, null: false
      t.integer :parent_cat_id, index: true
      t.string  :name, null: false
      t.string  :label, null: false
      t.boolean :leaf, null: false
      t.string  :cat_property_models, array: true, default: []
      t.json    :rules, default: {}
      t.integer :lsc_set_id, default: 0
      t.boolean :variation_cat, default: false
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
