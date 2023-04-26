require 'rails_helper'

RSpec.describe "tasks/new", type: :view do
  before(:each) do
    assign(:task, Task.new(
      :title => "MyString",
      :user => nil,
      :dietitian => nil,
      :patient => nil
    ))
  end

  it "renders new task form" do
    render

    assert_select "form[action=?][method=?]", tasks_path, "post" do

      assert_select "input[name=?]", "task[title]"

      assert_select "input[name=?]", "task[user_id]"

      assert_select "input[name=?]", "task[dietitian_id]"

      assert_select "input[name=?]", "task[patient_id]"
    end
  end
end
