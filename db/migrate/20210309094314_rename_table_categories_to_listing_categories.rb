class RenameTableCategoriesToListingCategories < ActiveRecord::Migration[6.0]
  def change
    rename_table :categories, :listing_categories
  end
end
