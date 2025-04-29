class CreatePositions < ActiveRecord::Migration[7.2]
  def change
    create_table :positions do |t|
      t.references :merchandise_rate, null: false, foreign_key: true
      t.string :result
      t.datetime :start_date
      t.datetime :end_date
      t.string :order_type
      t.integer :leverage
      t.float :entry
      t.float :escape
      t.float :return_usdt
      t.float :return_change
      t.float :position_total
      t.float :balance
      t.text :note
      t.integer :period_min
      t.integer :period_hour
      t.float :period_day

      t.timestamps
    end
  end
end
