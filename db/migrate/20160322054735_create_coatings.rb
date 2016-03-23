class CreateCoatings < ActiveRecord::Migration
  def change
    create_table :coatings do |t|
      t.string :front
      t.string :back

      t.timestamps null: false
    end
  end
end
