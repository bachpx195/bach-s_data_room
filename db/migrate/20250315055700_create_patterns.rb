class CreatePatterns < ActiveRecord::Migration[7.2]
  def change
    create_table :patterns do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.string :pattern_type
      t.references :merchandise_rate, null: false, foreign_key: true
      t.integer :parent_id
      
      t.timestamps
    end
  end
end
