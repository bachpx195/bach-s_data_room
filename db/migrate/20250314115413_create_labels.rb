class CreateLabels < ActiveRecord::Migration[7.2]
  def change
    create_table :labels do |t|
      t.string :name
      t.string :slug
      t.string :color
      t.text :description

      t.timestamps
    end
  end
end
