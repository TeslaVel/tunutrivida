require 'rails_helper'

RSpec.describe "indicators/edit", type: :view do
  before(:each) do
    @indicator = assign(:indicator, Indicator.create!(
      :value_min => 1,
      :value_max => 1,
      :description => "MyString",
      :gender => nil
    ))
  end

  it "renders the edit indicator form" do
    render

    assert_select "form[action=?][method=?]", indicator_path(@indicator), "post" do

      assert_select "input[name=?]", "indicator[value_min]"

      assert_select "input[name=?]", "indicator[value_max]"

      assert_select "input[name=?]", "indicator[description]"

      assert_select "input[name=?]", "indicator[gender_id]"
    end
  end
end
