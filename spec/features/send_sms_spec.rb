require 'spec_helper'
require 'feature_helper'

feature "Send SMS" do
  before (:all) do
    @message = FactoryGirl.build(:message)
    @text_message = @message.text_messages.build(firstname: "John", phone_number: "2185566465")
  end

  it "uploads and parses a CSV file" do
    # @message = FactoryGirl.build(:message)
    visit csv_upload_message_text_messages_url(:message_id =>@message.id)
    click_button "Choose File"
    select_file "../data/valid_csv.csv'"
    click_button "Import"
    current_path.should eq(import_confirmation_message_text_messages_url)
    page.should have_content("Phone numbers uploaded: 2")
  end

  it "integrate with Twilio's API to send a text message to all the phone numbers in that file" do
    # @message = FactoryGirl.build(:message)
    # @text_message = @message.text_messages.build(firstname: "John", phone_number: "612")
    visit import_confirmation_message_text_messages_url
    click_button "Send!"
    current_path.should eq(send_confirmation_message_text_messages_url)
    page.should have_content("Done.")
  end

  it "successfully sends the message" do
      @client = Twilio::REST::Client.new(ENV["TEST_ACCOUNT_SID"], ENV["TEST_AUTH_TOKEN"])
      @account = @client.accounts.get(ENV["TEST_ACCOUNT_SID"])
      # @message = FactoryGirl.build(:message)
      from = ENV["TWILIO_NUMBER"]
      @message.text_messages.each do |text_message|
        client.account.messages.create(
          :from => from,
          :to => text_message.phone_number.gsub(/^(\+1)|[^0-9]+/,''),
          :body => "Hey #{text_message.firstname}, #{@message.content}"
        )
      status = @client.account.messages.list.status
      expect(status).to eq("sent")
  end

  it "confirms all recipients received the message" do
    to = @client.account.messages.list.last.to
    expect(to).to eq("+12185566465")
  end

  it "sends the message prefixed with the recipients first name." do
    @message.body.should have_content("Hey John")
  end 

  it "after successfully sending all the text messages, the app should show a 'success' screen."

  it "reports when messages have been sent" do
    visit import_confirmation_message_text_messages_url
    click_button "Send!"
    current_path.should eq(send_confirmation_message_text_messages_url)
    page.should have_content("Done.")
  end

end
