require 'spec_helper'

describe Message do

	it "has many text messages" do
    t = Message.reflect_on_association(:text_messages)
    expect(t.macro).to eq(:has_many)
  end

  it "is invalid with empty content" do
		message = FactoryGirl.build(:message, content: nil)
		expect(message).to have(1).errors_on(:content)
	end

	it "is accessible with 'message_id'" do
		message = FactoryGirl.build(:message)
		expect(message.message_id).to eq(message.id)
	end

end
