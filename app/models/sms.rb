class Sms < ActiveRecord::Base
	belongs_to :message
	validates :phone_number, :firstname, presence: true
	validates :phone_number, :phone_number => {:ten_digits => true}

end
