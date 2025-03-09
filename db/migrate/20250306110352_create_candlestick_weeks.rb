class CreateCandlestickWeeks < ActiveRecord::Migration[7.2]
  def change
    create_table :candlestick_weeks do |t|
      t.references :merchandise_rate, null: false, foreign_key: true
      t.date :date
      t.string :candlestick_type
      t.float :return_oc
      t.float :return_hl
      t.float :open
      t.float :high
      t.float :close
      t.float :low
      t.float :volumn
      t.integer :week_master_id
      t.string :timestamp
      t.integer :parent_id
      t.timestamps
    end

    add_index :candlestick_weeks, :date
    add_index :candlestick_weeks, :timestamp
  end
end

