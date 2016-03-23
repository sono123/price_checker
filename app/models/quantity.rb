class Quantity < ActiveRecord::Base
	validates :quantity, presence: true
	validates_numericality_of :quantity, on: :create
end
