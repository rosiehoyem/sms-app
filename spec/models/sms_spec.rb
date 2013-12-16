require 'spec_helper'

describe Sms do  

	it "is invalid without a firstname" do
		sms = FactoryGirl.build(:sms, first_name: nil)
		expect(sms).to have(1).errors_on(:first_name)
	end
	
	it "is invalid without a valid 10-digit phone number" do
		sms = FactoryGirl.build(:sms, phone_number: "218556646")
		expect(sms).to have(1).errors_on(:phone_number)
	end

the form should have 2 fields: the first is 'message' and the second is 'CSV upload'.  

	it "accepts a CSV file upload and parses the file"

	it "integrate with Twilio's API to send a text message to all the phone numbers in that file"

	it "sucessfully reproduces the message specified on the form"

	it "sends the message to all valid entries in the CVS upload"  

	it "sends the message prefixed with the recipients first name."  

describe Confirmation do

"after successfully sending all the text messages, the app should show a "success" screen."

end