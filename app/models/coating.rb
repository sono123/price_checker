class Coating < ActiveRecord::Base
	validates :front, :back, presence: true
end
