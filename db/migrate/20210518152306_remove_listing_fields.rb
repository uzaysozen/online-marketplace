class RemoveListingFields < ActiveRecord::Migration[6.0]
  def change
    remove_columns :listings, :moderator_id
  end
end
