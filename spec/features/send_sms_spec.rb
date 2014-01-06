require 'spec_helper'
require 'feature_helper'

describe "Send SMS", :type => :feature do
  before (:each) do
    @message = FactoryGirl.build(:message)
    @text_message = @message.text_messages.build(firstname: "John", phone_number: "2185566465")
    @client = Twilio::REST::Client.new(ENV["TEST_ACCOUNT_SID"], ENV["TEST_AUTH_TOKEN"])
    @account = @client.accounts.get(ENV["TEST_ACCOUNT_SID"])
  end

  it "uploads and parses a CSV file" do
    visit "/messages/:message_id/text_messages/csv_upload"
    page.attach_file("file_upload", "./spec/data/valid_csv.csv") 
    click_button "Import"
    current_path.should eq(import_confirmation_message_text_messages_url)
    page.should have_content("Phone numbers uploaded: 2")
  end

  it "integrate with Twilio's API to send a text message to all the phone numbers in that file" do
    visit import_confirmation_message_text_messages_url
    click_button "Send!"
    current_path.should eq(send_confirmation_message_text_messages_url)
    page.should have_content("Done.")
  end

  it "successfully sends the message" do
    from = ENV["TWILIO_NUMBER"]
    @message.text_messages.each do |text_message|
      client.account.messages.create(
        :from => from,
        :to => text_message.phone_number.gsub(/^(\+1)|[^0-9]+/,''),
        :body => "Hey #{text_message.firstname}, #{@message.content}"
      )
    end
    status = @client.account.messages.list.status
    expect(status).to eq("sent")
  end

  it "confirms all recipients received the message" do
    to = @client.account.messages.list.last.to
    expect(to).to eq(@text_message.phone_number.gsub("+1", ""))
  end

  it "sends the message prefixed with the recipients first name." do
    body = @client.account.messages.list.last.body
    expect(body).to have_content("Hey John")
  end 

  it "reports when messages have been sent" do
    visit import_confirmation_message_text_messages_url
    click_button "Send!"
    current_path.should eq(send_confirmation_message_text_messages_url)
    page.should have_content("SENT")
  end

end
