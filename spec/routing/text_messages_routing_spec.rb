require "spec_helper"

describe TextMessagesController do
  describe "routing" do

    it "routes to #csv_upload" do
      get("/messages/1/text_messages/csv_upload").should route_to("text_messages#csv_upload", :message_id => "1")
    end

    it "routes to #import" do
      post("/messages/1/text_messages/import").should route_to("text_messages#import", :message_id => "1")
    end

    it "routes to #import_confirmation" do
      get("/messages/1/text_messages/import_confirmation").should route_to("text_messages#import_confirmation", :message_id => "1")
    end

    it "routes to #send_sms" do
      post("/messages/1/text_messages/send_sms").should route_to("text_messages#send_sms", :message_id => "1")
    end

    it "routes to #send_confirmation" do
      get("/messages/1/text_messages/send_confirmation").should route_to("text_messages#send_confirmation", :message_id => "1")
    end

  end
end
