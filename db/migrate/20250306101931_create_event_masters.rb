class CreateEventMasters < ActiveRecord::Migration[7.2]
  def change
    create_table :event_masters do |t|
      t.references :merchandise_rate, null: false, foreign_key: true
      t.string :name
      t.string :slug
      t.text :description
      t.string :time
      t.text :note

      t.timestamps
    end
  end
end
