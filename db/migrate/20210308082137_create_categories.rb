class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.bigint :parent_id, :null => true
      
      t.timestamps :created_at
      t.timestamps :updated_at
      t.timestamps
    end
  end
end
