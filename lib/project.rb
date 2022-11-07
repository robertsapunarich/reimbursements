class Project
  attr_reader :city_type, :start_date, :end_date
  
  def initialize(city_type, start_date, end_date)
    @city_type = city_type
    @start_date = start_date
    @end_date = end_date
  end

  def sum_full_days
    if one_day_project?
      0
    else
      days = (end_date - start_date).to_i
      days = days - 1 unless days == 0
      days * full_rate
    end
  end

  def sum_travel_days
    if one_day_project?
      travel_rate
    else
      travel_rate * 2
    end
  end

  def high_cost?
    self.city_type == :high_cost
  end

  def low_cost?
    self.city_type == :low_cost
  end

  private

  def travel_rate
    low_cost? ? 45 : 55
  end

  def full_rate
    low_cost? ? 75 : 85 
  end

  def one_day_project?
    end_date == start_date
  end
end