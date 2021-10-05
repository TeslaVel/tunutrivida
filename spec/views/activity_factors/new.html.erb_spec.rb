require 'rails_helper'

RSpec.describe "activity_factors/new", type: :view do
  before(:each) do
    assign(:activity_factor, ActivityFactor.new(
      :name => "MyString",
      :description => "MyText",
      :value => 1
    ))
  end

  it "renders new activity_factor form" do
    render

    assert_select "form[action=?][method=?]", activity_factors_path, "post" do

      assert_select "input[name=?]", "activity_factor[name]"

      assert_select "textarea[name=?]", "activity_factor[description]"

      assert_select "input[name=?]", "activity_factor[value]"
    end
  end
end
