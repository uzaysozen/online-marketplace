class AddModeratorToListing < ActiveRecord::Migration[6.0]
  def change
    add_column :listings, :moderator_id, :bigint
  end
end
