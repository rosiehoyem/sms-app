require 'spec_helper'

describe TextMessagesController do

  let(:valid_attributes) { {:firstname => "John", :phone_number => "6125555555"  } }

  describe "GET #csv_upload" do

    it "renders the csv_upload template" do
      message = FactoryGirl.create(:message)
      get :csv_upload, message_id: message
      response.should render_template("csv_upload")
    end

    it "assigns the requested message to message" do
      message = FactoryGirl.create(:message)
      get :csv_upload, message_id: message
      expect(assigns(:message)).to eq message
    end
  end

  describe "POST #import" do
    it "imports a csv file and builds a new TextMessage from message" do
      message = FactoryGirl.create(:message)
      file = Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/data/valid_csv.csv')))
      expect {
        message.text_messages.import(file)
      }.to change(TextMessage, :count).by(2)
  end

  describe "GET #import_confirmation" do
    it "renders the import_confirmation template" do
      message = FactoryGirl.create(:message)
      get :import_confirmation, message_id: message
      response.should render_template("import_confirmation")
    end

    it "assigns the requested message to @message" do
      message = FactoryGirl.create(:message)
      get :import_confirmation, message_id: message
      expect(assigns(:message)).to eq message
    end

    describe "Twilio account status" do
      before (:each) do
        @client = Twilio::REST::Client.new(ENV["ACCOUNT_SID"], ENV["AUTH_TOKEN"])
        @account = @client.accounts.get(ENV["ACCOUNT_SID"])
      end

      it "is a trial account" do
        expect(@account.type).to eq("Trial")
      end

      it "is active" do
        expect(@account.status).to eq("active")
      end
    end
  end

  describe "POST #send_sms" do
     before (:each) do
      @message = FactoryGirl.build(:message)
      @text_message = @message.text_messages.build(firstname: "Rosie", phone_number: "2185566465")
      @client = Twilio::REST::Client.new(ENV["TEST_ACCOUNT_SID"], ENV["TEST_AUTH_TOKEN"])
      @account = @client.accounts.get(ENV["TEST_ACCOUNT_SID"])
    end

    it "redirects to the send confirmation page upon send" do
      post :send_sms, message_id: message
      expect(response).to redirect_to send_confirmation_message_text_messages_url
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
  end

  describe "GET #send_confirmation" do
    it "renders the send_confirmation template" do
      message = FactoryGirl.create(:message)
      get :send_confirmation, message_id: message
      response.should render_template("send_confirmation")
    end

    it "assigns the requested message to @message" do
      message = FactoryGirl.create(:message)
      get :send_confirmation, message_id: message
      expect(assigns(:message)).to eq message
    end
  end

end
