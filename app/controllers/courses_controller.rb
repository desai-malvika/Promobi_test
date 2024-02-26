class CoursesController < ApplicationController
	def index
		courses = Course.includes(:tutors)
    render json: courses, each_serializer: CourseWithTutorsSerializer
	end

	def create
    course = Course.new(course_params)
    if course.save
      render json: course, serializer: CourseWithTutorsSerializer, status: :created
    else
      render json: { errors: course.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, tutors_attributes: [:name, :experience, :skills])
  end
end
