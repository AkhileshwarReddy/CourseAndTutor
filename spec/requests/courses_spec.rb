require 'rails_helper'

RSpec.describe "Courses", type: :request do
  describe "POST /courses" do
    let(:computer_science) { build(:course, title: 'Computer Science') }
    let(:mechanical) { build(:course, title: 'Mechanical Engineering') }

    let(:john_doe) { build(:tutor, name: 'John Doe') }
    let(:jane_doe) { build(:tutor, name: 'Jane Doe') }

    context 'with valid parameters' do
      it 'creates a new course and tutors' do
        expect {
          post "/courses", params: { course: { title: computer_science.title,
                                               description: computer_science.description,
                                               tutors_attributes: [{ name: john_doe.name }, { name: jane_doe.name }] } }
        }.to change(Course, :count).by(1)
                                   .and change(Tutor, :count).by(2)

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'returns an error' do
        expect {
          post "/courses", params: { course: { name: '' } }
        }.not_to change(Course, :count)

        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'GET /index' do
    context 'with existing courses and tutors' do
      it 'returns a list of courses with tutors' do
        computer_science = create(:course, title: 'Computer Science')
        mechanical = create(:course, title: 'Mechanical Engineering')

        create(:tutor, name: 'John Doe', course: computer_science)
        create(:tutor, name: 'Jane Doe', course: mechanical)

        get "/courses"

        _res = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
      end
    end

    context 'without any existing courses and tutors' do
      it 'returns 400 status code' do
        get "/courses"

        expect(response).to have_http_status(:bad_request)
        body = JSON.parse(response.body)
        expect(body['message']).to eq(I18n.t('course.errors.show_all'))
      end
    end
  end
end
