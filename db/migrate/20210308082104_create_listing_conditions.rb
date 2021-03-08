class CreateListingConditions < ActiveRecord::Migration[6.0]
  def change
    create_table :listing_conditions do |t|

      t.timestamps
    end
  end
end
