require 'rails_helper'

RSpec.describe Mood, type: :model do
  it "has the expected fields" do
    User.create(id: "1")
    m = Mood.new
    m.user_id = "1"
    m.date = "2017-01-01"
    m.mood = 5
    m.description = "outdoors, Thundercats, pitchfork"
    m.save
    expect(m.errors).to be_empty
  end

  it "loads data from a CSV" do
    User.import_from_csv
    Mood.import_from_csv
    expect(Mood.count).to eq 151
  end
end
