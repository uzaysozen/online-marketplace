class CreateConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :conversations do |t|
      t.bigint :listing_id
      t.bigint :participant_id

      t.timestamps :created_at
      t.timestamps :updated_at
      t.timestamps
    end
  end
end
