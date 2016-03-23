class CreatePrintMethods < ActiveRecord::Migration
  def change
    create_table :print_methods do |t|
      t.string :print_method

      t.timestamps null: false
    end
  end
end
