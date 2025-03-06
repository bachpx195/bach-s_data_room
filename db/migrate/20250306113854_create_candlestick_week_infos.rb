class CreateCandlestickWeekInfos < ActiveRecord::Migration[7.2]
  def change
    create_table :candlestick_week_infos do |t|
      t.date :date
      t.string :candlestick_type
      t.float :return_oc
      t.float :return_hl
      t.boolean :is_inside_week
      t.boolean :is_same_btc
      t.boolean :is_continue_increase
      t.boolean :is_continue_decrease
      t.boolean :is_fake_breakout_increase
      t.boolean :is_fake_breakout_decrease
      t.integer :continue_by_week
      t.references :merchandise_rate, null: false, foreign_key: true
      t.references :candlestick_week, null: false, foreign_key: true
      t.references :week_master, null: false, foreign_key: true
      t.integer :timestamp
      t.integer :parent_id

      t.timestamps
    end

    add_index :candlestick_week_infos, :date
    add_index :candlestick_week_infos, :timestamp
  end
end
