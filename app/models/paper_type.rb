class PaperType < ActiveRecord::Base
	validates :name, presence: {message: "Please enter the paper name"}
	validates :color, presence: {message: "Please enter the color"}
	validates :thickness, presence: {message: "Please enter the thickness"}
	validates_numericality_of :thickness
end
