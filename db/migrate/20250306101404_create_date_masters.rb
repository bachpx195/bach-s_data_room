class CreateDateMasters < ActiveRecord::Migration[7.2]
  def change
    create_table :date_masters do |t|
      t.date :date
      t.string :date_name
      t.integer :date_number
      t.integer :month
      t.references :month_master, null: false, foreign_key: true
      t.integer :year
      t.references :year_master, null: false, foreign_key: true
      t.references :week_master, null: false, foreign_key: true
      t.text :note

      t.timestamps
    end

    add_index :date_masters, :date
  end
end
