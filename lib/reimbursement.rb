require_relative 'project'
require_relative 'project_day_set'

class Reimbursement
  attr_reader :amount
  
  def initialize(projects)
    @amount = calculate(projects)
  end

  private

  def calculate(projects)
    reimbursement = 0
    overlapping = []

    projects.each do |project|
      project.create_days_for_project!
    end

    project_days = projects.map(&:project_days).flatten

    project_day_set = ProjectDaySet.new(project_days)

    project_day_set.normalize!

    project_day_set.sum(reimbursement) { |day| reimbursement + day.cost }
  end
end