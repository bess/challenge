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
    u = User.find("271")
    expect(u.username).to eq "Rubie"
    expect(u.name).to eq "Madisyn Bauch"
    expect(u.zipcode).to eq "69662-4008"
  end
end
