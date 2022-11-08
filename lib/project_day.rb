class ProjectDay
  attr_reader :date, :city_type
  attr_accessor :workday_type

  def initialize(date, city_type, workday_type)
    @date = date
    @city_type = city_type
    @workday_type = workday_type
  end

  def cost
    case @workday_type
    when :travel
      travel_day_cost
    when :full
      full_day_cost
    end
  end

  def travel_day?
    @workday_type == :travel
  end

  def full_day?
    @workday_type == :full
  end
  
  def low_cost?
    @city_type == :low_cost
  end

  def high_cost?
    @city_type == :high_cost
  end

  private

  def travel_day_cost
    if @city_type == :high_cost
      55
    else
      45
    end
  end

  def full_day_cost
    if @city_type == :high_cost
      85
    else
      75
    end
  end
end