require 'rails_helper'

RSpec.describe "activity_factors/index", type: :view do
  before(:each) do
    assign(:activity_factors, [
      ActivityFactor.create!(
        :name => "Name",
        :description => "MyText",
        :value => 2
      ),
      ActivityFactor.create!(
        :name => "Name",
        :description => "MyText",
        :value => 2
      )
    ])
  end

  it "renders a list of activity_factors" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
