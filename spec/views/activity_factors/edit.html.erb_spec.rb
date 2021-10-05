require 'rails_helper'

RSpec.describe "activity_factors/edit", type: :view do
  before(:each) do
    @activity_factor = assign(:activity_factor, ActivityFactor.create!(
      :name => "MyString",
      :description => "MyText",
      :value => 1
    ))
  end

  it "renders the edit activity_factor form" do
    render

    assert_select "form[action=?][method=?]", activity_factor_path(@activity_factor), "post" do

      assert_select "input[name=?]", "activity_factor[name]"

      assert_select "textarea[name=?]", "activity_factor[description]"

      assert_select "input[name=?]", "activity_factor[value]"
    end
  end
end
