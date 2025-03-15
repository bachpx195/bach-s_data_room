class CreatePatternCandlestickDates < ActiveRecord::Migration[7.2]
  def change
    create_table :pattern_candlestick_dates do |t|
      t.references :pattern, null: false, foreign_key: true
      t.references :candlestick_date, null: false, foreign_key: true
      t.references :merchandise_rate, null: false, foreign_key: true
      t.date :date
      t.timestamps
    end
  end
end
