class CreateCandlestickHours < ActiveRecord::Migration[7.2]
  def change
    create_table :candlestick_hours do |t|
      t.references :merchandise_rate, null: false, foreign_key: true
      t.datetime :date
      t.date :date_with_binance
      t.integer :hour
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

      t.timestamps
    end

    add_index :candlestick_hours, :date
    add_index :candlestick_hours, :timestamp
  end
end

