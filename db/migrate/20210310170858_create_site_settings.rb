class CreateSiteSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :site_settings do |t|
      t.string :key, :limit => 50
      t.string :value
      t.text :blocked_words

      t.timestamps
    end
  end
end
