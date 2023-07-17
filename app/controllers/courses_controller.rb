class CoursesController < ApiController
  def index
    courses = course_service.fetch_all_courses
    render json: { courses: courses.as_json(include: [:tutors]) }
  end

  def create
    course = course_service.create_course_with_tutors(course_params)
    render json: { course: course.as_json(include: [:tutors]) }, status: :created
  end

  private

  def course_params
    params.require(:course).permit(:title, :description, tutors_attributes: [:name])
  end

  def course_service
    Services::CourseService.new
  end
end
