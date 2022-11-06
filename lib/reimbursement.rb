require_relative 'project'

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
      full_days_amt = project.sum_full_days
      travel_days_amt = project.sum_travel_days
      amt = full_days_amt + travel_days_amt

      reimbursement += amt
      overlapping << projects.select{|proj| (proj.start_date == project.end_date || proj.end_date == project.start_date) && proj != project}
    end

    overlapping = overlapping.flatten.uniq 

    if overlapping.size > 0
      subtract_amount = handle_overlapping(overlapping)
      reimbursement - subtract_amount
    else
      reimbursement
    end
  end

  def handle_overlapping(projects)
    amt = 0

    projects.each do |project|
      if project.high_cost? && projects.any?(&:low_cost?) || project.low_cost? && projects.any?(&:high_cost?)
        amt += 45
      end
      projects.delete(project)
    end

    amt
  end

end