class Dimension < ActiveRecord::Base
	validates_numericality_of :width, on: :create
	validates_numericality_of :height, on: :create
end
