class CreateStresses < ActiveRecord::Migration[6.0]
  def change
    create_table :stresses do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :date
      t.integer :stress

      t.timestamps
    end
  end
end
