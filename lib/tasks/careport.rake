namespace :careport do
  desc "Find all patients who had two or more bad days in the week of 2020-08-19"
  task bad_week_report: :environment do
    bad_week_users = []
    User.all.each do |u|
      next unless u.bad_week?("2017-01-01")
      puts "#{u.name} #{u.zipcode} #{u.bad_days_in_a_week('2017-01-01')}"
    end
  end

  desc "Find the 5 longest streaks of consecutive bad days"
  task bad_streak_report: :environment do

    longest_5_streaks = Streak.all.order(bad_days: :desc).first(14)
    longest_5_streaks.each do |streak|
      name = User.find(streak.user_id).name
      puts "#{name} : #{streak.bad_days} : #{streak.starting_date}"
    end
  end

  def detect_bad_day_streaks
    Streak.destroy_all
    User.all.each do |u|
      u.detect_bad_day_streaks
    end
  end

end
