require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the expected fields" do
    u = User.new
    u.id = 1
    u.username = "Miles"
    u.name = "Oceane Johnston"
    u.zipcode = "39437-7362"
    u.save
    expect(u.errors).to be_empty
  end

  it "can import from a CSV" do
    # 271,Rubie,Madisyn Bauch,69662-4008
    User.import_from_csv
    expect(User.count).to eq 1
  end

  context "knowing when a day was bad" do
    let(:user) { User.create(id: 1, username: 'jane', name: 'Jane Quest', zipcode: '27510') }
    let(:bad_mood_day) { Mood.create(user_id: user.id, date: "2017-01-15", mood: 1) }
    let(:good_mood_day) { Mood.create(user_id: user.id, date: "2017-01-16", mood: 4) }
    let(:missing_mood_data) { Mood.create(user_id: user.id, date: "2017-01-11") }
    let(:missing_stress_data) { Stress.create(user_id: user.id, date: "2017-01-11") }
    let(:stressful_date) { "2017-01-17" }
    let(:stressful_day) do
      Mood.create(user_id: user.id, date: stressful_date, mood: 3)
      Stress.create(user_id: user.id, date: stressful_date, stress: 4)
    end

    it "was a bad day if mood was 1 or 2" do
      expect(user.bad_day?(bad_mood_day.date)).to eq true
    end
    it "was a good day if mood was 4 or 5" do
      expect(user.bad_day?(good_mood_day.date)).to eq false
    end
    it "returns a mood of 3 if the mood data is missing" do
      expect(user.mood_for_date(missing_mood_data.date)).to eq 3
    end
    it "returns a stress of 3 if the stress data is missing" do
      expect(user.stress_for_date(missing_stress_data.date)).to eq 3
    end
    it "was a bad day if mood == 3 and stress >= 4" do
      stressful_day
      expect(user.bad_day?(stressful_date)).to eq true
    end
  end

  # Given the starting day of a week, were there two or more bad days in it?
  context "knowing when a week was bad" do
    before do
      User.import_from_csv
      Mood.import_from_csv
      Stress.import_from_csv
    end
    it "knows how many bad days in a week" do
      user = User.create(id: 5, username: 'jane', name: 'Jane Quest', zipcode: '27510')
      Mood.create(user_id: user.id, date: "2020-08-19", mood: 1)
      Mood.create(user_id: user.id, date: "2020-08-20", mood: 4)
      Mood.create(user_id: user.id, date: "2020-08-21", mood: 4)
      Mood.create(user_id: user.id, date: "2020-08-22", mood: 4)
      Mood.create(user_id: user.id, date: "2020-08-23", mood: 1)
      Mood.create(user_id: user.id, date: "2020-08-24", mood: 5)
      Mood.create(user_id: user.id, date: "2020-08-25", mood: 5)
      expect(user.bad_days_in_a_week("2020-08-19")).to eq 2
    end
    it "knows when a user has had a bad week" do
      user = User.create(id: 5, username: 'jane', name: 'Jane Quest', zipcode: '27510')
      Mood.create(user_id: user.id, date: "2020-08-19", mood: 1)
      Mood.create(user_id: user.id, date: "2020-08-20", mood: 4)
      Mood.create(user_id: user.id, date: "2020-08-21", mood: 4)
      Mood.create(user_id: user.id, date: "2020-08-22", mood: 4)
      Mood.create(user_id: user.id, date: "2020-08-23", mood: 1)
      Mood.create(user_id: user.id, date: "2020-08-24", mood: 5)
      Mood.create(user_id: user.id, date: "2020-08-25", mood: 5)
      expect(user.bad_week?("2020-08-19")).to eq true
    end
    it "knows when a user has had a good week" do
      user = User.create(id: 5, username: 'jane', name: 'Jane Quest', zipcode: '27510')
      Mood.create(user_id: user.id, date: "2020-08-19", mood: 1)
      Mood.create(user_id: user.id, date: "2020-08-20", mood: 4)
      Mood.create(user_id: user.id, date: "2020-08-21", mood: 4)
      Mood.create(user_id: user.id, date: "2020-08-22", mood: 4)
      Mood.create(user_id: user.id, date: "2020-08-23", mood: 4)
      Mood.create(user_id: user.id, date: "2020-08-24", mood: 5)
      Mood.create(user_id: user.id, date: "2020-08-25", mood: 5)
      expect(user.bad_week?("2020-08-19")).to eq false
    end
  end

  # it "knows when a day was 'bad'" do
  #   User.import_from_csv
  #   Mood.import_from_csv
  #   Stress.import_from_csv
  #   user = User.first
  #
  #   # day was bad if mood was 2
  #   expect(user.bad_day?("2017-01-15")).to eq true
  #
  #   # day was good if mood was 4
  #   expect(user.bad_day?("2017-01-22")).to eq false
  #
  #   # day was bad if mood == 3 and stress >= 4
  #   expect(user.bad_day?("2017-01-15")).to eq true
  #
  # end
end
