class CreateInkColors < ActiveRecord::Migration
  def change
    create_table :ink_colors do |t|
      t.integer :front
      t.integer :back

      t.timestamps null: false
    end
  end
end
