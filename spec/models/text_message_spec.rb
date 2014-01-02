require 'spec_helper'

describe TextMessage do  

	it "is invalid without a firstname" do
		text_message = FactoryGirl.build(:text_message, first_name: nil)
		expect(text_message).to have(1).errors_on(:first_name)
	end
	
	it "is invalid without a valid 10-digit phone number" do
		text_message = FactoryGirl.build(:text_message, phone_number: "218556646")
		expect(text_message).to have(1).errors_on(:phone_number)
	end
  

	it "accepts a CSV file upload and parses the file"

	it "integrate with Twilio's API to send a text message to all the phone numbers in that file"

	it "sucessfully reproduces the message specified on the form"

	it "sends the message to all valid entries in the CVS upload"  

	it "sends the message prefixed with the recipients first name."  

	it "after successfully sending all the text messages, the app should show a 'success' screen."

end