class CreateCandlestickDates < ActiveRecord::Migration[7.2]
  def change
    create_table :candlestick_dates do |t|
      t.references :merchandise_rate, null: false, foreign_key: true
      t.date :date
      t.string :date_name
      t.string :candlestick_type
      t.float :return_oc
      t.float :return_hl
      t.float :open
      t.float :high
      t.float :close
      t.float :low
      t.float :volumn
      t.string :timestamp
      t.integer :parent_id
      t.integer :parent_month_id

      t.timestamps
    end

    add_index :candlestick_dates, :date
    add_index :candlestick_dates, :timestamp
  end
end
