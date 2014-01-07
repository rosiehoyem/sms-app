class Message < ActiveRecord::Base
	has_many :text_messages
	validates :content, presence: true
	
	def message_id
  	self.id
  end
end
