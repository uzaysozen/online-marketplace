class AddRatingToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :rating, :float
    add_column :users, :rating_count, :bigint

    remove_columns :listings, :is_active, :is_moderated
  end
end
