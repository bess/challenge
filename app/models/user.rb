require 'csv'

class User < ApplicationRecord
  has_many :moods
  has_many :stresses

  def self.import_file
    return Rails.root.join('spec','fixtures','dataset','users.csv') if Rails.env == 'test'
    Rails.root.join('app','dataset','users.csv')
  end

  def self.import_from_csv
    table = CSV.parse(File.read(User.import_file), headers: true)
    table.by_row.each do |row|
      User.create(id: row["id"], name: row["name"], username: row["username"], zipcode: row["zipcode"])
    end
  end

  # We're going to define a bad day as a day when:
  #     a patient's mood is 1 or 2
  #     a patients's mood is a 3, but their stress for that same day is a 4 or 5
  def bad_day?(date)
    mood = mood_for_date(date)
    return true if mood <= 2
    return false if mood >= 4
    # Otherwise, mood must be 3, so measure stress
    stress = stress_for_date(date)
    return true if stress >= 4
    false
  end

  def mood_for_date(date)
    mood = moods.find_by(date: date)&.mood
    return 3 if mood.nil?
    mood
  end

  def stress_for_date(date)
    stress = stresses.find_by(date: date)&.stress
    return 3 if stress.nil?
    stress
  end

  # Given a date, how many bad days in the week starting on that date?
  def bad_days_in_a_week(date)
    return @bad_days_in_a_week if @bad_days_in_a_week
    bad_days = 0
    day = Date.parse(date)
    for i in 0..6
      bad_days +=1 if bad_day?((day + i.days).to_s)
    end
    @bad_days_in_a_week = bad_days
    bad_days
  end

  # Given a date, were there 2 or more bad days in the week starting on that date?
  def bad_week?(date)
    bad_days = bad_days_in_a_week(date)
    return true if bad_days >= 2
    false
  end

end
