class CreateMerchandises < ActiveRecord::Migration[7.2]
  def change
    create_table :merchandises do |t|
      t.references :tag, null: false, foreign_key: true
      t.string :name
      t.string :slug
      t.string :founder
      t.string :company
      t.string :country
      t.text :about

      t.timestamps
    end
  end
end
