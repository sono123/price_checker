class CreateMetals < ActiveRecord::Migration
  def change
    create_table :metals do |t|
      t.string :front
      t.string :back

      t.timestamps null: false
    end
  end
end
