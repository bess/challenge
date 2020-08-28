require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        username: "Username",
        name: "Name",
        zipcode: "Zipcode"
      ),
      User.create!(
        username: "Username",
        name: "Name",
        zipcode: "Zipcode"
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", text: "Username".to_s, count: 2
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Zipcode".to_s, count: 2
  end
end
