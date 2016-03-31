class Metal < ActiveRecord::Base
	validates :front, :back, presence: true, length: { minimum: 4 }
end
