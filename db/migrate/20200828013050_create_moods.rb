class CreateMoods < ActiveRecord::Migration[6.0]
  def change
    create_table :moods do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :date
      t.integer :mood
      t.string :description

      t.timestamps
    end
  end
end
