class BoxCount < ActiveRecord::Base
	validates :box_count, presence: {message: "Please enter a box count"}
	validates_numericality_of :box_count
end
