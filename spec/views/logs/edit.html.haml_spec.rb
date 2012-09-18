require 'spec_helper'

describe "logs/edit" do
  before(:each) do
    @log = assign(:log, stub_model(Log,
      :project_id => 1,
      :user_id => 1,
      :body => "MyText"
    ))
  end

  it "renders the edit log form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => logs_path(@log), :method => "post" do
      assert_select "input#log_project_id", :name => "log[project_id]"
      assert_select "input#log_user_id", :name => "log[user_id]"
      assert_select "textarea#log_body", :name => "log[body]"
    end
  end
end
