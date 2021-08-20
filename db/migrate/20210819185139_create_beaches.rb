class CreateBeaches < ActiveRecord::Migration[6.1]
  def change
    create_table :beaches do |t|
      t.string :title
      t.text :description
      t.string :location
      t.string :tide_dependency
      t.string :water_quality
      t.string :water_quality_date
      t.string :warnings
      t.integer :rating
      t.decimal :lat
      t.decimal :long

      t.timestamps
    end
  end
end
