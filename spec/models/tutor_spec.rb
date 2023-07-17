require 'rails_helper'

RSpec.describe Tutor, type: :model do
  let(:tutor) { build(:tutor) }

  describe 'validations' do
    context 'name' do
      it 'must be present' do
        tutor.name = nil
        expect(tutor.valid?).to be_falsey
      end

      it 'should have minimum of 5 characters' do
        tutor.name = "John"
        expect(tutor.valid?).to be_falsey
      end
    end
  end

  describe 'associations' do
    context 'course' do
      it 'must be present' do
        tutor.course = nil
        expect(tutor.valid?).to be_falsey
      end
    end
  end
end
