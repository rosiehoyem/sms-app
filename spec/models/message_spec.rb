require 'spec_helper'

describe Message do
  it "is invalid with empty content" do
		message = FactoryGirl.build(:message, content: nil)
		expect(message).to have(1).errors_on(:content)
	end
end
