class Message < ActiveRecord::Base
	has_many :text_messages
	validates :content, presence: true
	
end
