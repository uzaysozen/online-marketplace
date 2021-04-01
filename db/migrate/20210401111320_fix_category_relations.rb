class FixCategoryRelations < ActiveRecord::Migration[6.0]
  def change
    change_table :listing_categories do |t|
      t.remove :parent_id

      t.references :parent_category, foreign_key: { to_table: :listing_categories}
    end

    change_table :listings do |t|
      t.remove :listing_category_id

      t.belongs_to :listing_category, foreign_key: "listing_category_id"
    end
  end
end
