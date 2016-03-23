class CreatePaperTypes < ActiveRecord::Migration
  def change
    create_table :paper_types do |t|
      t.string :brand
      t.string :name
      t.string :color
      t.integer :thickness

      t.timestamps null: false
    end
  end
end
