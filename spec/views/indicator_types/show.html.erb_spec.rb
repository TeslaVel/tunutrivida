require 'rails_helper'

RSpec.describe "indicator_types/show", type: :view do
  before(:each) do
    @indicator_type = assign(:indicator_type, IndicatorType.create!(
      :name => "MyText",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Description/)
  end
end
