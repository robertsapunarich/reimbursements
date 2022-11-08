require_relative 'project_day'

class ProjectDaySet < Array
  def normalize!
    self.sort_by{|day| day.date }
    handle_overlapping
  end

  private

  def handle_overlapping
    remove_duplicate_travel_days_for_city_type
    remove_low_cost_duplicate_travel_days
    set_workday_types
  end

  def remove_duplicate_travel_days_for_city_type
    self.uniq!{|day| [day.date, day.workday_type, day.city_type] }
  end

  def remove_low_cost_duplicate_travel_days
    travel_days = self.select{|day| day.travel_day?}
    travel_days.each do |travel_day|
      self.reject!{|day| day.travel_day? && day.date == travel_day.date && day.low_cost? && day != travel_day}
    end
  end

  def set_workday_types
    self[0].workday_type = :travel
    self[-1].workday_type = :travel

    self.each_with_index do |day, i|
      unless day == self.first || day == self.last
        if (self[i - 1].travel_day? && (day.date - self[i - 1].date).to_i == 1) || (day.travel_day? && (day.date - self[i - 1].date).to_i == 1)
          day.workday_type = :full
        end
      end 
    end

  end
end