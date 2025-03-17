class CreateRangeCandlestickMonths < ActiveRecord::Migration[7.2]
  def change
    create_table :range_candlestick_months do |t|
      t.date :date
      t.float :mean_oc
      t.float :mean_hl
      t.float :standard_deviation_oc
      t.float :standard_deviation_hl
      t.references :candlestick_month, null: false, foreign_key: true
      t.references :merchandise_rate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
