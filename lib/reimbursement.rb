require_relative 'project'

class Reimbursement
  attr_reader :amount
  
  def initialize(projects)
    @amount = calculate(projects)
  end

  private

  def calculate(projects)
    reimbursement = 0
    
    projects.each do |project|
      reimbursement += (project.sum_full_days + project.sum_travel_days)
    end
    
    reimbursement
  end

end