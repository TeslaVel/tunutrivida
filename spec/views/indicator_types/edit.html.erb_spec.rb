require 'rails_helper'

RSpec.describe "indicator_types/edit", type: :view do
  before(:each) do
    @indicator_type = assign(:indicator_type, IndicatorType.create!(
      :name => "MyText",
      :description => "MyString"
    ))
  end

  it "renders the edit indicator_type form" do
    render

    assert_select "form[action=?][method=?]", indicator_type_path(@indicator_type), "post" do

      assert_select "textarea[name=?]", "indicator_type[name]"

      assert_select "input[name=?]", "indicator_type[description]"
    end
  end
end
