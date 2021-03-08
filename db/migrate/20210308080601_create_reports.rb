class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.text :message
      t.text :outcome
      t.bigint :moderator_id
      t.bigint :user_id
      t.bigint :listing_id
      t.bigint :message_id
      
      t.timestamps
    end
  end
end
