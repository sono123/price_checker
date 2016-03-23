class CreateRaisedInks < ActiveRecord::Migration
  def change
    create_table :raised_inks do |t|
      t.integer :front
      t.integer :back

      t.timestamps null: false
    end
  end
end
