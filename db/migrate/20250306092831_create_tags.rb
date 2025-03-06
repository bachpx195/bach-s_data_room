class CreateTags < ActiveRecord::Migration[7.2]
  def change
    create_table :tags do |t|
      t.string :title
      t.string :slug
      t.integer :parent_id

      t.timestamps
    end
  end
end
