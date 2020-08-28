require 'csv'

class Stress < ApplicationRecord
  belongs_to :user

  def self.import_file
    return Rails.root.join('spec','fixtures','dataset','stress.csv') if Rails.env == 'test'
    Rails.root.join('app','dataset','stress.csv')
  end

  def self.import_from_csv
    table = CSV.parse(File.read(Stress.import_file), headers: true)
    table.by_row.each do |row|
      Stress.create(user_id: row["userid"], date: row["date"], stress: row["stress"])
    end
  end
end
