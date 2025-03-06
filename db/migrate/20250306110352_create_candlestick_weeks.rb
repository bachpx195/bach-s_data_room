class CreateCandlestickWeeks < ActiveRecord::Migration[7.2]
  def change
    create_table :candlestick_weeks do |t|
      t.references :merchandise_rate, null: false, foreign_key: true
      t.date :date
      t.float :open
      t.float :high
      t.float :close
      t.float :low
      t.float :volumn

      t.timestamps
    end

    add_index :candlestick_weeks, :date
  end
end
