class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :details
      t.references :user
      t.references :beach

      t.timestamps
    end
  end
end
