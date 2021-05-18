class AddUserNotificationSettings < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :when, :text
    add_column :users, :email_message, :bool
    add_column :users, :email_category, :bool
    add_column :users, :user_categories, :text, array: true, default: [], using: "(string_to_array(content, ','))"
  end
end
