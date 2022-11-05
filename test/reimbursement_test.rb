require 'minitest/autorun'
require_relative '../lib/reimbursement'

# ---The Rules---
# First day and last day of a project, or sequence of projects, is a travel day.
# Any day in the middle of a project, or sequence of projects, is considered a full day.
# - R.S. 11/5/22 Does this mean that days between projects in the same set should be reimbursed as well?
# If there is a gap between projects, then the days on either side of that gap are travel days.
# - R.S. 11/5/22 Is this just another way of stating that the first and last days of a project are travel days?
# If two projects push up against each other, or overlap, then those days are full days as well.
# - R.S. 11/5/22 Does this mean that days which would normally be 'travel days' should be reimbursed as full days?
# Any given day is only ever counted once, even if two projects are on the same day.
# A travel day is reimbursed at a rate of 45 dollars per day in a low cost city.
# A travel day is reimbursed at a rate of 55 dollars per day in a high cost city.
# A full day is reimbursed at a rate of 75 dollars per day in a low cost city.
# A full day is reimbursed at a rate of 85 dollars per day in a high cost city.
# - R.S. 11/5/22 If two projects, one low cost and the other high cost, start and end on the same day,
# - which reimbursement rate (high or low cost) should supersede the other?

class ReimbursementTest < Minitest::Test


  set_1 = [
    Project.new(:low_cost, Date.new(2015, 09, 01), Date.new(2015, 09, 03))
  ]

  set_2 = [
    Project.new(:low_cost, Date.new(2015, 09, 01), Date.new(2015, 09, 01)),
    Project.new(:high_cost, Date.new(2015, 09, 02), Date.new(2015, 09, 06)),
    Project.new(:low_cost, Date.new(2015, 09, 06), Date.new(2015, 09, 08))
  ]

  set_3 = [
    Project.new(:low_cost, Date.new(2015, 09, 01), Date.new(2015, 09, 03)),
    Project.new(:high_cost, Date.new(2015, 09, 05), Date.new(2015, 09, 07)),
    Project.new(:high_cost, Date.new(2015, 09, 08), Date.new(2015, 09, 08))
  ]

  set_4 = [
    Project.new(:low_cost, Date.new(2015, 09, 01), Date.new(2015, 09, 01)),
    Project.new(:low_cost, Date.new(2015, 09, 01), Date.new(2015, 09, 01)),
    Project.new(:high_cost, Date.new(2015, 09, 02), Date.new(2015, 09, 02)),
    Project.new(:high_cost, Date.new(2015, 09, 02), Date.new(2015, 09, 03))
  ]

  
end