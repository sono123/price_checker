class CreateBoxCounts < ActiveRecord::Migration
  def change
    create_table :box_counts do |t|
      t.integer :box_count

      t.timestamps null: false
    end
  end
end
