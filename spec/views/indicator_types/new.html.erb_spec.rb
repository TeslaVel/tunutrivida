require 'rails_helper'

RSpec.describe "indicator_types/new", type: :view do
  before(:each) do
    assign(:indicator_type, IndicatorType.new(
      :name => "MyText",
      :description => "MyString"
    ))
  end

  it "renders new indicator_type form" do
    render

    assert_select "form[action=?][method=?]", indicator_types_path, "post" do

      assert_select "textarea[name=?]", "indicator_type[name]"

      assert_select "input[name=?]", "indicator_type[description]"
    end
  end
end
