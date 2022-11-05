class Project
  attr_reader :city_type, :start_date, :end_date
  
  def initialize(city_type, start_date, end_date)
    @city_type = city_type
    @start_date = start_date
    @end_date = end_date
  end

  
end