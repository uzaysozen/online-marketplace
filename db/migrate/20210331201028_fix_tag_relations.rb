class FixTagRelations < ActiveRecord::Migration[6.0]
  def change
    change_table :listing_tags do |t|
      t.remove :listing_id, :tag_id

      t.belongs_to :listing, foreign_key: "listing_id"
      t.belongs_to :tag, foreign_key: "tag_id"
    end
  end
end
