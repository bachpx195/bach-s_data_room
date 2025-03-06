class CreateCandlestickHours < ActiveRecord::Migration[7.2]
  def change
    create_table :candlestick_hours do |t|
      t.references :merchandise_rate, null: false, foreign_key: true
      t.datetime :date
      t.float :open
      t.float :high
      t.float :close
      t.float :low
      t.float :volumn

      t.timestamps
    end
  end
end
