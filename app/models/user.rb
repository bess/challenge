require 'csv'

class User < ApplicationRecord


  def self.import_from_csv
    table = CSV.parse(File.read(Rails.root.join('app','dataset','users.csv')), headers: true)
    table.by_row.each do |row|
      User.create(id: row["id"], name: row["name"], username: row["username"], zipcode: row["zipcode"])
    end
  end
end
