class CreateBleeds < ActiveRecord::Migration
  def change
    create_table :bleeds do |t|
      t.boolean :front
      t.boolean :back

      t.timestamps null: false
    end
  end
end
