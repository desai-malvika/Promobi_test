require 'rails_helper'

RSpec.describe Course, type: :model do
  it { should have_many(:tutors) }
  it { should accept_nested_attributes_for(:tutors) }
  it 'validates presence of name' do
    course = Course.new(name: nil)
    course.valid?
    expect(course.errors[:name]).to include("can't be blank")
  end
end