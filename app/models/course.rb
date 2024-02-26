class Course < ApplicationRecord
	has_many :tutors
	validates :name,  presence: true
	accepts_nested_attributes_for :tutors
end
