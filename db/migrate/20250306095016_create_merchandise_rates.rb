class CreateMerchandiseRates < ActiveRecord::Migration[7.2]
  def change
    create_table :merchandise_rates do |t|
      t.references :tag, null: false, foreign_key: true
      t.string :name
      t.string :slug
      t.integer :base_id
      t.integer :quote_id

      t.timestamps
    end
  end
end
