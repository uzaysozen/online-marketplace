class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.bigint :parent_id, :null => true
      
      t.timestamps
    end
  end
end
