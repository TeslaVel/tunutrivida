require 'rails_helper'

RSpec.describe "indicators/show", type: :view do
  before(:each) do
    @indicator = assign(:indicator, Indicator.create!(
      :value_min => 2,
      :value_max => 3,
      :description => "Description",
      :gender => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(//)
  end
end
