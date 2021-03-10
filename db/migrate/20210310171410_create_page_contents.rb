class CreatePageContents < ActiveRecord::Migration[6.0]
  def change
    create_table :page_contents do |t|
      t.string :key, :limit => 50
      t.text :content

      t.timestamps
    end
  end
end
