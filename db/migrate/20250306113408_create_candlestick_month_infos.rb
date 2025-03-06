class CreateCandlestickMonthInfos < ActiveRecord::Migration[7.2]
  def change
    create_table :candlestick_month_infos do |t|
      t.date :date
      t.string :candlestick_type
      t.float :return_oc
      t.float :return_hl
      t.boolean :is_inside_month
      t.boolean :is_same_btc
      t.boolean :is_continue_increase
      t.boolean :is_continue_decrease
      t.boolean :is_fake_breakout_increase
      t.boolean :is_fake_breakout_decrease
      t.integer :continue_by_year
      t.integer :continue_by_month
      t.references :merchandise_rate, null: false, foreign_key: true
      t.references :candlestick_month, null: false, foreign_key: true
      t.integer :year
      t.integer :month
      t.integer :timestamp
      t.integer :parent_id

      t.timestamps
    end

    add_index :candlestick_month_infos, :date
    add_index :candlestick_month_infos, :timestamp
  end
end
