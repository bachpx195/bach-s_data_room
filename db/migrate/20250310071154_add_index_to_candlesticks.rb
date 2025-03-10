class AddIndexToCandlesticks < ActiveRecord::Migration[7.2]
  def change
    add_index :candlestick_dates, :parent_id
    add_index :candlestick_dates, :parent_month_id
    add_index :candlestick_hours, :parent_id
  end
end
