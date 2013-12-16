describe "Send SMS" do
  it "uploads and parses a CSV file" do
    sms = Factory(:sms)
    visit send_path
    fill_in "Message", :with => "#{sms.firstname} test message"
    click_link "Find CSV File"
    select_file "../features/test_files/test.cvs"
    click_button "Upload CSV File"
    current_path.should eq(root_path)
    page.should have_content("Upload Sucessful. Ready to Send.")
    last_email.to.should include(user.email)
  end

  it "does not save records with invalid phone numbers" do
    visit send_path
    fill_in "Message", :with => "#{sms.firstname} test message"
    click_link "Find CSV File"
    select_file "../features/test_files/invalid-test.cvs"
    click_button "Upload CSV File"
    current_path.should eq(root_path)
    page.should have_content("Invalid phone number.")
    last_message.should be_nil
  end

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