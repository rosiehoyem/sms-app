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
    context "with valid params" do
      it "imports a csv file and builds a new TextMessage from message" do
        message = FactoryGirl.create(:message)
        file = Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/data/valid_csv.csv')))
        expect {
          message.text_messages.import(file)
        }.to change(TextMessage, :count).by(2)
      end

      # it "redirects to the import confirmation page upon save" do
      #   message = FactoryGirl.create(:message)
      #   file = Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/data/valid_csv.csv')))
      #   post :import, message_id: message
      #   # ?
      #   expect(response).to redirect_to import_confirmation_message_text_messages_url
      # end
    end
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

  describe "POST send_sms" do
    context "with valid params" do
      # it "sends an sms message" do
      #   message = FactoryGirl.create(:message)
      #   text_message = message.text_messages.build(firstname: "Rosie", phone_number: "2185566465")
      #   post :send_sms, message_id: message
      #   expect(response).to be_ok
      # end

      it "redirects to the send confirmation page upon send" do
        message = FactoryGirl.create(:message)
        text_message = message.text_messages.build(firstname: "Rosie", phone_number: "2185566465")
        post :send_sms, message_id: message
        expect(response).to redirect_to send_confirmation_message_text_messages_url
      end
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
