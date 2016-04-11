class Metal < ActiveRecord::Base
	validates :front, :back, presence: true
end
