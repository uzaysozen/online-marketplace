class ChangeColumnCategoryIdToListingCategoryId < ActiveRecord::Migration[6.0]
  def change
    rename_column :listings, :category_id, :listing_category_id
  end
end
