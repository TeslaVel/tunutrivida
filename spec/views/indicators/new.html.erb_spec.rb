require 'rails_helper'

RSpec.describe "indicators/new", type: :view do
  before(:each) do
    assign(:indicator, Indicator.new(
      :value_min => 1,
      :value_max => 1,
      :description => "MyString",
      :gender => nil
    ))
  end

  it "renders new indicator form" do
    render

    assert_select "form[action=?][method=?]", indicators_path, "post" do

      assert_select "input[name=?]", "indicator[value_min]"

      assert_select "input[name=?]", "indicator[value_max]"

      assert_select "input[name=?]", "indicator[description]"

      assert_select "input[name=?]", "indicator[gender_id]"
    end
  end
end
