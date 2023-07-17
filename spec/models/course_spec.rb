require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'validations' do
    let(:course) { build(:course) }

    context 'title' do
      it 'must be present' do
        course.title = nil
        expect(course.valid?).to be_falsey
      end

      it 'should have minimum 10 characters' do
        course.title = "Course 1"
        expect(course.valid?).to be_falsey
      end

      it 'must be unique' do
        some_course = create(:course)
        course.title = some_course.title
        expect(course.valid?).to be_falsey
      end
    end

    context 'description' do
      it 'can be optional' do
        course.description = nil
        expect(course.valid?).to be_truthy
      end
    end
  end
end
