class ChangeReceiverToNull < ActiveRecord::Migration[6.0]
  def change
    change_column :listings, :receiver_id, :bigint, :null => true
    remove_column :listings, :price
    add_column :listings, :price, :decimal
  end
end
