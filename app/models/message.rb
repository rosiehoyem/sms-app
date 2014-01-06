class Message < ActiveRecord::Base
	has_many :text_messages
	validates :content, presence: true
	
	def message_id
  	self.id
  end

  def update(message)
  	client = Twilio::REST::Client.new(ENV["ACCOUNT_SID"], ENV["AUTH_TOKEN"])
    account = client.accounts.get(ENV["ACCOUNT_SID"])
		message.status = client.account.messages.get(message.twilio_sid).status
		message.date_sent = client.account.messages.get(message.twilio_sid).date_sent
		message.save
  end

end
