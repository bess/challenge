class Mood < ApplicationRecord
  belongs_to :user

  def self.import_file
    return Rails.root.join('spec','fixtures','dataset','moods.csv') if Rails.env == 'test'
    Rails.root.join('app','dataset','moods.csv')
  end

  def self.import_from_csv
    table = CSV.parse(File.read(Mood.import_file), headers: true)
    table.by_row.each do |row|
      Mood.create(user_id: row["userid"], date: row["date"], mood: row["mood"], description: row["description"])
    end
  end
end
