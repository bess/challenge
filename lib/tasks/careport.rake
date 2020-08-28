namespace :careport do
  desc "Find all patients who had two or more bad days in the week of 2020-08-19"
  task bad_week_report: :environment do
    bad_week_users = []
    User.all.each do |u|
      next unless u.bad_week?("2017-01-01")
      puts "#{u.name} #{u.zipcode} #{u.bad_days_in_a_week('2017-01-01')}"
      # bad_week_entry = [u.name, u.zipcode, u.bad_days_in_a_week("2020-08-19")]
      # bad_week_users << bad_week_entry
    end
    # puts bad_week_users.inspect
  end

end
