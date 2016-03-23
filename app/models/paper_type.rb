class PaperType < ActiveRecord::Base
	validates :brand, :name, :color, :thickness, presence: true
	validates_numericality_of :thickness, on: :create
end
