module Services
  class CourseService
    include Errors::ErrorHandler

    attr_reader :course_adapter

    def initialize(course_adapter: DataAdapters::Courses)
      @course_adapter = course_adapter
    end

    def fetch_all_courses
      @course_adapter.new.fetch_all_courses
    end

    def create_course_with_tutors(data)
      raise ApiValidationError, I18n.t('course.errors.create_params_missing') if course_params_missing?(data)
      raise ApiValidationError, I18n.t('course.tutors.errors.create_params_missing') if tutor_params_missing?(data)
      @course_adapter.new.create_course_with_tutors(data)
    end

    private

    def course_params_missing?(data)
      title_missing?(data)
    end

    def tutor_params_missing?(data)
      data[:tutors_attributes].reduce(false) { |result, tutor| result ||= name_missing?(tutor) }
    end

    def title_missing?(data)
      data[:title].blank?
    end

    def name_missing?(data)
      data[:name].blank?
    end
  end
end