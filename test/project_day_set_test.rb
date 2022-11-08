require 'minitest/autorun'
require 'date'
require_relative '../lib/project'
require_relative '../lib/project_day'
require_relative '../lib/project_day_set'

class ProjectDaySetTest < Minitest::Test
  SET_1 = [
    Project.new(:low_cost, Date.new(2015, 9, 01), Date.new(2015, 9, 03))
  ]

  SET_1_DAYS = SET_1.map(&:create_days_for_project!).flatten

  SET_2 = [
    Project.new(:low_cost, Date.new(2015, 9, 1), Date.new(2015, 9, 1)), # 45 (since it begins and ends on the same day)
    Project.new(:high_cost, Date.new(2015, 9, 2), Date.new(2015, 9, 6)), # 425 — the start and end are both full days
    Project.new(:low_cost, Date.new(2015, 9, 6), Date.new(2015, 9, 8)) # 165 - 45 = 120 (since it shares a travel day with the previous project)
  ]

  SET_2_DAYS = SET_2.map(&:create_days_for_project!).flatten

  SET_3 = [
    Project.new(:low_cost, Date.new(2015, 9, 1), Date.new(2015, 9, 3)), # 165
    Project.new(:high_cost, Date.new(2015, 9, 5), Date.new(2015, 9, 7)), # 225
    Project.new(:high_cost, Date.new(2015, 9, 8), Date.new(2015, 9, 8)) # 55
  ]

  SET_3_DAYS = SET_3.map(&:create_days_for_project!).flatten

  SET_4 = [
    Project.new(:low_cost, Date.new(2015, 9, 1), Date.new(2015, 9, 1)), # 45
    Project.new(:low_cost, Date.new(2015, 9, 1), Date.new(2015, 9, 1)), # 0 — because only one day should be reimbursed, even if there are multiple projects
    Project.new(:high_cost, Date.new(2015, 9, 2), Date.new(2015, 9, 2)), # 85 - because this should be treated as a full day
    Project.new(:high_cost, Date.new(2015, 9, 2), Date.new(2015, 9, 3)) # 55 — since the first day is being treated as a full day
  ]

  SET_4_DAYS = SET_4.map(&:create_days_for_project!).flatten
  
  def test_set_1_normalize!
    project_day_set = ProjectDaySet.new(SET_1_DAYS)
    project_day_set.normalize!
    travel_days = project_day_set.select{|day| day.workday_type == :travel}
    full_days = project_day_set.select{|day| day.workday_type == :full}

    assert_equal 3, project_day_set.size
    assert_equal 2, travel_days.size
    assert_equal 1, full_days.size
  end

  def test_set_2_normalize!
    project_day_set = ProjectDaySet.new(SET_2_DAYS)
    project_day_set.normalize!
    travel_days = project_day_set.select{|day| day.workday_type == :travel}
    full_days = project_day_set.select{|day| day.workday_type == :full}

    assert_equal 8, project_day_set.size
    assert_equal 2, travel_days.size
    assert_equal 6, full_days.size
  end

  def test_set_3_normalize!
    project_day_set = ProjectDaySet.new(SET_3_DAYS)
    project_day_set.normalize!
    travel_days = project_day_set.select{|day| day.workday_type == :travel}
    full_days = project_day_set.select{|day| day.workday_type == :full}

    assert_equal 7, project_day_set.size
    assert_equal 4, travel_days.size
    assert_equal 3, full_days.size
  end

  def test_set_4_normalize!
    project_day_set = ProjectDaySet.new(SET_4_DAYS)
    project_day_set.normalize!
    travel_days = project_day_set.select{|day| day.workday_type == :travel}
    full_days = project_day_set.select{|day| day.workday_type == :full}

    assert_equal 3, project_day_set.size
    assert_equal 2, travel_days.size
    assert_equal 1, full_days.size
  end

end