class CreateListingQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :listing_questions do |t|
      t.string :question, :limit => 50
      t.string :answer, :limit => 50
      t.bigint :listing_id

      t.timestamps
    end
  end
end
