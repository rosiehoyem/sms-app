class TextMessage < ActiveRecord::Base
	belongs_to :message
	validates :phone_number, :firstname, presence: true
	validates :phone_number, :phone_number => {:ten_digits => true, :message => "invalid and can only be attributable to human error"}

	def self.import(file)
	  CSV.foreach(file.path, headers: true) do |row|
	    TextMessage.create! row.to_hash
	  end
	end

end
