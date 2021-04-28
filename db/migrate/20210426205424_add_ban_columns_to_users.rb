class AddBanColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_banned, :boolean, default: false
    add_column :users, :ban_reason, :text
  end
end
