require 'rails_helper'

RSpec.describe "tasks/edit", type: :view do
  before(:each) do
    @task = assign(:task, Task.create!(
      :title => "MyString",
      :user => nil,
      :dietitian => nil,
      :patient => nil
    ))
  end

  it "renders the edit task form" do
    render

    assert_select "form[action=?][method=?]", task_path(@task), "post" do

      assert_select "input[name=?]", "task[title]"

      assert_select "input[name=?]", "task[user_id]"

      assert_select "input[name=?]", "task[dietitian_id]"

      assert_select "input[name=?]", "task[patient_id]"
    end
  end
end
