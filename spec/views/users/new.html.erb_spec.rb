require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      username: "MyString",
      name: "MyString",
      zipcode: "MyString"
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input[name=?]", "user[username]"

      assert_select "input[name=?]", "user[name]"

      assert_select "input[name=?]", "user[zipcode]"
    end
  end
end
