class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :count
      t.integer :range
      t.date :date

      t.timestamps
    end
  end
end
