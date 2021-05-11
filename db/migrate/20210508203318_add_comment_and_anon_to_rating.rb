class AddCommentAndAnonToRating < ActiveRecord::Migration[6.0]
  def change
    add_column :listing_ratings, :buyer_comment, :text
    add_column :listing_ratings, :seller_comment, :text
    add_column :listing_ratings, :buyer_anon, :bool
    add_column :listing_ratings, :seller_anon, :bool
  end
end
