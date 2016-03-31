class BoxCount < ActiveRecord::Base
	validates :box_count, presence: true
	validates_numericality_of :box_count
end
