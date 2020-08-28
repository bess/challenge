class CreateStreaks < ActiveRecord::Migration[6.0]
  def change
    create_table :streaks do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :bad_days
      t.date :starting_date

      t.timestamps
    end
  end
end
