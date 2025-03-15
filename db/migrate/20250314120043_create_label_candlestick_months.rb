class CreateLabelCandlestickMonths < ActiveRecord::Migration[7.2]
  def change
    create_table :label_candlestick_months do |t|
      t.references :label, null: false, foreign_key: true
      t.references :candlestick_month, null: false, foreign_key: true
      t.references :merchandise_rate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
