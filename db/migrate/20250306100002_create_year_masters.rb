class CreateYearMasters < ActiveRecord::Migration[7.2]
  def change
    create_table :year_masters do |t|
      t.date :start_date
      t.integer :year

      t.timestamps
    end
  end
end
