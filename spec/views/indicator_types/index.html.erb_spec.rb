require 'rails_helper'

RSpec.describe "indicator_types/index", type: :view do
  before(:each) do
    assign(:indicator_types, [
      IndicatorType.create!(
        :name => "MyText",
        :description => "Description"
      ),
      IndicatorType.create!(
        :name => "MyText",
        :description => "Description"
      )
    ])
  end

  it "renders a list of indicator_types" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
