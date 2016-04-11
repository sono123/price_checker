class Quantity < ActiveRecord::Base
	validates :quantity, presence: {message: "Please enter a quantity"}
	validates_numericality_of :quantity
end
