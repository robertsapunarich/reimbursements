class Project
  attr_reader :city_type, :start_date, :end_date
  
  def initialize(city_type, start_date, end_date)
    @city_type = city_type
    @start_date = start_date
    @end_date = end_date
  end

  def sum_full_days
    if same_day_trip?
      0
    else
      rate = low_cost? ? 75 : 85
      days = (end_date - start_date).to_i
      days = days - 1 unless days == 0
      days * rate
    end
  end

  def sum_travel_days
    rate = low_cost? ? 45 : 55
    if same_day_trip?
      rate
    else
      rate * 2
    end
  end

  def high_cost?
    self.city_type == :high_cost
  end

  def low_cost?
    self.city_type == :low_cost
  end
  
  def same_day_trip?
    end_date == start_date
  end
end