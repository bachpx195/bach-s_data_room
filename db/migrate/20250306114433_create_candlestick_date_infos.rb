class CreateCandlestickDateInfos < ActiveRecord::Migration[7.2]
  def change
    create_table :candlestick_date_infos do |t|
      t.date :date
      t.string :date_name
      t.string :candlestick_type
      t.float :return_oc
      t.float :return_hl
      t.boolean :is_inside_day
      t.boolean :is_same_btc
      t.boolean :is_continue_increase
      t.boolean :is_continue_decrease
      t.boolean :is_fake_breakout_increase
      t.boolean :is_fake_breakout_decrease
      t.integer :continue_by_day
      t.references :merchandise_rate, null: false, foreign_key: true
      t.references :candlestick_date, null: false, foreign_key: true
      t.integer :timestamp
      t.integer :parent_id
      t.integer :parent_month_id

      t.timestamps
    end

    add_index :candlestick_date_infos, :date
    add_index :candlestick_date_infos, :timestamp
  end
end
