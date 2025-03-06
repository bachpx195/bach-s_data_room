class CreateDateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :date_events do |t|
      t.references :date_master, null: false, foreign_key: true
      t.references :event_master, null: false, foreign_key: true
      t.references :merchandise_rate, null: false, foreign_key: true
      t.references :candlestick_date_info, null: false, foreign_key: true
      t.text :note

      t.timestamps
    end
  end
end
