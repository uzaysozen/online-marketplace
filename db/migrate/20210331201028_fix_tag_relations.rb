class FixTagRelations < ActiveRecord::Migration[6.0]
  def change
    change_table :listing_tags do |t|
      t.remove :listing_id, :tag_id

      t.belongs_to :listing
      t.belongs_to :tag
    end
  end
end
