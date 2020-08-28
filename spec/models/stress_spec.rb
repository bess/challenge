require 'rails_helper'

RSpec.describe Stress, type: :model do
  it "can import from a CSV" do
    User.import_from_csv
    Stress.import_from_csv
    expect(Stress.count).to eq 152
  end
end
