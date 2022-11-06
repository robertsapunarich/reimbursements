class Project
  attr_reader :city_type, :start_date, :end_date
  
  def initialize(city_type, start_date, end_date)
    @city_type = city_type
    @start_date = start_date
    @end_date = end_date
  end

  def sum_full_days
    rate = city_type == :low_cost ? 75 : 85
    days = (end_date - start_date).to_i - 1
    days * rate
  end

  def sum_travel_days
    rate = city_type == :low_cost ? 45 : 55
    rate * 2
  end

end