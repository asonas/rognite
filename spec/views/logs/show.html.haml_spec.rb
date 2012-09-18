require 'spec_helper'

describe "logs/show" do
  before(:each) do
    @log = assign(:log, stub_model(Log,
      :project_id => 1,
      :user_id => 2,
      :body => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/MyText/)
  end
end
