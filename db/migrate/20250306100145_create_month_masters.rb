class CreateMonthMasters < ActiveRecord::Migration[7.2]
  def change
    create_table :month_masters do |t|
      t.date :start_date
      t.integer :month
      t.integer :year
      t.references :year_master, null: false, foreign_key: true

      t.timestamps
    end
  end
end
