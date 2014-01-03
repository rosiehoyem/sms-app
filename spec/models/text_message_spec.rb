require 'spec_helper'

describe TextMessage do  

	it "belongs to a message" do
    t = TextMessage.reflect_on_association(:message)
    expect(t.macro).to eq(:belongs_to)
  end

	it "is invalid without a firstname" do
		text_message = FactoryGirl.build(:text_message, firstname: nil)
		expect(text_message).to have(1).errors_on(:firstname)
	end
	
	it "is invalid without a valid 10-digit phone number" do
		text_message = FactoryGirl.build(:text_message, phone_number: "218556646")
		expect(text_message).to have(1).errors_on(:phone_number)
	end
  
	it "accepts a CSV file upload and parses the file" do
		file = Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/data/valid_csv.csv')))
			CSV.foreach(file.path, headers: true) do |row|
		    TextMessage.create! row.to_hash
		  end
		expect(TextMessage.all.count).to eq(2)
	end

end