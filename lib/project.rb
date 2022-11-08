require_relative 'project_day'

class Project
  attr_reader :city_type, :start_date, :end_date, :project_days
  
  def initialize(city_type, start_date, end_date)
    @city_type = city_type
    @start_date = start_date
    @end_date = end_date
  end

  def create_days_for_project!
    @project_days = []
    (start_date..end_date).each do |date|
      workday_type = date == start_date || date == end_date ? :travel : :full
      @project_days << ProjectDay.new(date, city_type, workday_type)
    end

    @project_days
  end

end