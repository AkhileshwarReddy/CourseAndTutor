module DataAdapters
  class Courses
    include Errors::ErrorHandler

    def initialize(course_class=Course)
      @course_class = course_class
    end

    def fetch_all_courses
      courses = @course_class.includes(:tutors).all

      raise ApiValidationError, I18n.t('course.errors.show_all') if courses.count == 0

      courses
    end

    def create_course_with_tutors(data)
      course_title = data[:title]
      course = @course_class.find_by_title(course_title)

      raise ApiValidationError, I18n.t('course.errors.create') if course.present?

      @course_class.create(data)
    end
  end
end