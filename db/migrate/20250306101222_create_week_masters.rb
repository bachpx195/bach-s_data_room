class CreateWeekMasters < ActiveRecord::Migration[7.2]
  def change
    create_table :week_masters do |t|
      t.date :start_date
      t.integer :month
      t.integer :year
      t.integer :overlap_month
      t.integer :number_in_month
      t.integer :year_master
      t.references :month_master, null: false, foreign_key: true

      t.timestamps
    end
  end
end
