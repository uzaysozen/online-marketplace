class ChangePageContentTableContentColumn < ActiveRecord::Migration[6.0]
  def change
    change_column :page_contents, :content, :text, array: true, default: []
  end
end
