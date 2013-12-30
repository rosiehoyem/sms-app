class TextMessage < ActiveRecord::Base
	belongs_to :message
	validates :phone_number, :firstname, presence: true
	validates :phone_number, :phone_number => {:ten_digits => true}

	def self.import(file)
	  CSV.foreach(file.path, headers: true) do |row|
	    Product.create! row.to_hash
	  end
	end

end
