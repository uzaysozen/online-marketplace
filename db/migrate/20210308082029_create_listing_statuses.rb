class CreateListingStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :listing_statuses do |t|

      t.timestamps
    end
  end
end
