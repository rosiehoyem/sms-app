class TextMessage < ActiveRecord::Base
	belongs_to :message
	validates :phone_number, :firstname, presence: true
	validates :phone_number, :phone_number => {:ten_digits => true}

	def self.import(file)
	  CSV.foreach(file.path, headers: true) do |row|
	    TextMessage.create! row.to_hash
	  end
	end

	# def send_sms
	# 	client = Twilio::REST::Client.new account_sid, auth_token
		 
	# 	from = "+6122940689" # Your Twilio number

	# 	message.text_messages.each do |text_message|
	# 	  client.account.messages.create(
	# 	    :from => from,
	# 	    :to => text_message.phone_number,
	# 	    :body => "Hey #{text_message.firstname}, #{message}"
	# 	  ) 
	# 	end
	# end

end
