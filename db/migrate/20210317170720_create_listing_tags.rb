class CreateListingTags < ActiveRecord::Migration[6.0]
  def change
    create_table :listing_tags do |t|
      t.bigint :listing_id 
      t.bigint :tag_id

      t.timestamps
    end
  end
end
