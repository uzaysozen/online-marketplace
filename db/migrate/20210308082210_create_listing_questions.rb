class CreateListingQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :listing_questions do |t|

      t.timestamps
    end
  end
end
