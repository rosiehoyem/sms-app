describe "Send SMS" do
  it "creates a new message" do
    visit root_path
    fill_in "content", :with => "test message"
    click_button "Create Message"
    last_message.should eq("test message")
  end

  it "uploads and parses a CSV file"
    @message = FactoryGirl.build(:message)
    visit csv_upload_message_text_messages_url(:message_id =>@message.id)
    click_button "Choose File"
    select_file "../data/valid_csv.csv'"
    click_button "Import"
    current_path.should eq(import_confirmation_message_text_messages_url)
    page.should have_content("Phone numbers uploaded: 2")
  end

  it "integrate with Twilio's API to send a text message to all the phone numbers in that file"
    @message = FactoryGirl.build(:message)
    @text_message = @message.text_messages.build(firstname: "John", phone_number: "612")
    visit import_confirmation_message_text_messages_url
    click_button "Send!"
    current_path.should eq(import_confirmation_message_text_messages_url)
    page.should have_content("Phone numbers uploaded: 2")
  end

  it "sucessfully reproduces the message specified on the form"

  it "sends the message to all valid entries in the CVS upload"  

  it "sends the message prefixed with the recipients first name."  

  it "after successfully sending all the text messages, the app should show a 'success' screen."

  it "reports when messages have been sent" do
    user = Factory(:user, :password_reset_token => "something", :password_reset_sent_at => 5.hour.ago)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in "Password", :with => "foobar"
    fill_in "Password confirmation", :with => "foobar"
    click_button "Update Password"
    page.should have_content("Password reset has expired")
  end

  it "raises record not found when password token is invalid" do
    lambda {
      visit edit_password_reset_path("invalid")
    }.should raise_exception(ActiveRecord::RecordNotFound)
  end
end