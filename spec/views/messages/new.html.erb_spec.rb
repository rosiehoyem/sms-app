require 'spec_helper'

describe "messages/new" do
  before(:each) do
    assign(:message, stub_model(Message).as_new_record)
  end

  it "renders new message form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", messages_path, "post" do
    end
  end
  
  it "should have 2 fields: the first is 'message' and the second is 'CSV upload'."

end