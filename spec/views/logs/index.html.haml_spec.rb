require 'spec_helper'

describe "logs/index" do
  before(:each) do
    assign(:logs, [
      stub_model(Log,
        :project_id => 1,
        :user_id => 2,
        :body => "MyText"
      ),
      stub_model(Log,
        :project_id => 1,
        :user_id => 2,
        :body => "MyText"
      )
    ])
  end

  it "renders a list of logs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
