class Message < ActiveRecord::Base
	has_many :smses
	validates :content, presence: true
	
end
