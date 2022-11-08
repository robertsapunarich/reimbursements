require 'minitest/autorun'
require 'date'
require_relative '../lib/project'
require_relative '../lib/project_day'

class ProjectTest < Minitest::Test

  PROJECT = Project.new(:low_cost, Date.new(2015, 9, 01), Date.new(2015, 9, 03))

  def test_create_days_for_project!
    project_days = PROJECT.create_days_for_project!
    assert_equal project_days.size, 3
    project_days.each do |day|
      assert day.low_cost?
    end
    assert project_days.select{|day| day.workday_type == :travel}.size == 2
  end
  
end