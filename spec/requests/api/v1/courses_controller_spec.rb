require 'rails_helper'

RSpec.describe "Api::V1::Courses", type: :request do
  describe 'GET #index' do
    it 'returns a success response' do
      get api_v1_courses_path
      expect(response).to have_http_status(:success)
    end

    it 'renders JSON with courses and tutors' do
			course = Course.create(name: "Test Course", description: "Description of course")
			tutor = Tutor.create(name: "Test Tutor", experience: 5, skills: "HTML", course_id: course.id)

			get api_v1_courses_path
			response_json = JSON.parse(response.body)

			expected_response = [
					{
						"id" => course.id,
						"name" => 'Test Course',
						"description" => "Description of course",
						"tutors" => [
								{
								"id" => tutor.id,
								"name" => 'Test Tutor',
								"experience" => 5,
								"skills" => "HTML"
								}
						]
				}
			]
			expect(response_json).to eq(expected_response)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new course' do
        expect {
          post api_v1_courses_path, params: { course: { name: 'New Course', description: 'Description', tutors_attributes: [{ name: 'New Tutor', experience: 3, skills: 'Ruby' }] } }
        }.to change(Course, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'returns unprocessable entity status' do
        post api_v1_courses_path, params: { course: { description: 'Invalid Course' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error messages in JSON response' do
        post api_v1_courses_path, params: { course: { description: 'Invalid Course' } }
        expect(JSON.parse(response.body)).to have_key('errors')
      end
    end
  end
end
