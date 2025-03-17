class CreateRangeCandlestickHours < ActiveRecord::Migration[7.2]
  def change
    create_table :range_candlestick_hours do |t|
      t.datetime :date
      t.float :mean_oc
      t.float :mean_hl
      t.float :standard_deviation_oc
      t.float :standard_deviation_hl
      t.references :candlestick_hour, null: false, foreign_key: true
      t.references :merchandise_rate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
