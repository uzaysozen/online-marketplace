class ChangeListingDefaultPriceToZero < ActiveRecord::Migration[6.0]
  def change
    change_column :listings, :price, :decimal, :default => 0.0
  end
end
