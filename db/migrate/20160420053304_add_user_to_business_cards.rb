class AddUserToBusinessCards < ActiveRecord::Migration
  def change
  	add_column :business_cards, :user_id, :integer, default: nil
  end
end
