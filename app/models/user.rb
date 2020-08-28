require 'csv'

class User < ApplicationRecord
  has_many :moods
  has_many :stresses
  has_many :streaks

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

  def earliest_mood_date
    moods.order(date: :asc).first.date
  end

  def latest_mood_date
    moods.order(date: :asc).last.date
  end

  def earliest_stress_date
    stresses.order(date: :asc).first.date
  end

  def latest_stress_date
    stresses.order(date: :asc).last.date
  end

  def first_data_day
    return earliest_mood_date if earliest_mood_date < earliest_stress_date
    earliest_stress_date
  end

  def last_data_day
    return latest_mood_date if latest_mood_date > latest_stress_date
    latest_stress_date
  end

  def detect_bad_day_streaks
    current_day = first_data_day
    on_a_streak = false
    streak_start_date = nil
    number_of_days_in_streak = 0
    while current_day <= last_data_day
      puts "#{current_day} : #{bad_day?(current_day)}"
      if bad_day?(current_day)
        # Start a streak
        if !on_a_streak
          on_a_streak = true
          streak_start_date = current_day
        end
        number_of_days_in_streak += 1
      else
        # end a streak if the current day is not a bad day
        if on_a_streak
          s = Streak.create(user_id: id, bad_days: number_of_days_in_streak, starting_date: streak_start_date)
          puts s.inspect
          on_a_streak = false
          number_of_days_in_streak = 0
        end
      end

      # also end the streak if today is the last day for which we have data
      if current_day == last_data_day
        if on_a_streak
          s = Streak.create(user_id: id, bad_days: number_of_days_in_streak, starting_date: streak_start_date)
          puts s.inspect
          on_a_streak = false
          number_of_days_in_streak = 0
        end
      end

      current_day += 1.day
    end
  end

end
