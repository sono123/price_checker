class Dimension < ActiveRecord::Base
	validates :width, presence: {message: "Please enter a width"}
	validates :height, presence: {message: "Please enter a height"}
	validates_numericality_of :width, :error => "Your entry was not a number"
	validates_numericality_of :height, :error => "Your entry was not a number"
end
