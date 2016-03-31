class PaperType < ActiveRecord::Base
	validates :name, :color, :thickness, presence: true
	validates_numericality_of :thickness
end
