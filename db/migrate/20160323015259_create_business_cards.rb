class CreateBusinessCards < ActiveRecord::Migration
  def change
    create_table :business_cards do |t|
      t.integer :price
      t.integer :cost
      t.references :print_method, index: true, foreign_key: true
      t.references :ink_color, index: true, foreign_key: true
      t.references :bleed, index: true, foreign_key: true
      t.references :raised_ink, index: true, foreign_key: true
      t.references :dimension, index: true, foreign_key: true
      t.references :paper_type, index: true, foreign_key: true
      t.references :coating, index: true, foreign_key: true
      t.references :quantity, index: true, foreign_key: true
      t.references :box_count, index: true, foreign_key: true
      t.references :metal, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
