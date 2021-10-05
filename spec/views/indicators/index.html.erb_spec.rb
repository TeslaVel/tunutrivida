require 'rails_helper'

RSpec.describe "indicators/index", type: :view do
  before(:each) do
    assign(:indicators, [
      Indicator.create!(
        :value_min => 2,
        :value_max => 3,
        :description => "Description",
        :gender => nil
      ),
      Indicator.create!(
        :value_min => 2,
        :value_max => 3,
        :description => "Description",
        :gender => nil
      )
    ])
  end

  it "renders a list of indicators" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
