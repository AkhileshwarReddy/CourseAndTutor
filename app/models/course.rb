class Course < ApplicationRecord
  validates :title, length: { minimum: 10 }, uniqueness: true
end
