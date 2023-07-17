class Tutor < ApplicationRecord
  belongs_to :course

  validates :name, presence: true, length: { minimum: 5 }
  validates_associated :course
end
