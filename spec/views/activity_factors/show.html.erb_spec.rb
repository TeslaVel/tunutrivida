require 'rails_helper'

RSpec.describe "activity_factors/show", type: :view do
  before(:each) do
    @activity_factor = assign(:activity_factor, ActivityFactor.create!(
      :name => "Name",
      :description => "MyText",
      :value => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
  end
end
