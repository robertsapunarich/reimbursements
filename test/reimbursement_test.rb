require_relative 'test_helper'
# ---The Rules---
# First day and last day of a project, or sequence of projects, is a travel day.
# - R.S. 11/6/22 What if a project starts and ends on the same day? Is it a travel day?
# - R.S. 11/6/22 Assume YES until told otherwise
# - AHT: Yes, if a project is a single day (and there's no project immediately before), then that's a travel day. 
#        They'll be going out and coming back the same day.
# Any day in the middle of a project, or sequence of projects, is considered a full day.
# - R.S. 11/5/22 Does this mean that days between projects in the same set should be reimbursed as well?
# — R.S. 11/6/22 Assume NO until otherwise.
# - AHT: Only days within a project are reimbursed. If there are no projects spanning a day, it has no reimbursement value.
# If there is a gap between projects, then the days on either side of that gap are travel days.
# - R.S. 11/5/22 Is this just another way of stating that the first and last days of a project are travel days?
# - R.S. 11/6/22 Assume YES until told otherwise.
# - AHT: Yes, with some nuance. First day is a travel day in isolation – 
#        but that can change if another project ends immediately before or on the first day 
#        or if another project already qualifies that day for a full day reimbursement. 
#        Same goes for the last day.
# If two projects push up against each other, or overlap, then those days are full days as well.
# - R.S. 11/5/22 Does this mean that days which would normally be 'travel days' should be reimbursed as full days?
# - R.S. 11/6/22 Assume YES until told otherwise.
# - AHT: Yes, exactly. If there are no gaps between projects, then treat those adjacent end and start days as full days. 
#        The idea is that they'll be scheduling people to do several projects all in the same area. 
#        If they need to travel significantly, they'll leave a gap day between the end of one and the start of the next.
# Any given day is only ever counted once, even if two projects are on the same day.
# A travel day is reimbursed at a rate of 45 dollars per day in a low cost city.
# A travel day is reimbursed at a rate of 55 dollars per day in a high cost city.
# A full day is reimbursed at a rate of 75 dollars per day in a low cost city.
# A full day is reimbursed at a rate of 85 dollars per day in a high cost city.
# - R.S. 11/5/22 If two projects, one low cost and the other high cost, start and end on the same day,
# - which reimbursement rate (high or low cost) should supersede the other?
# - R.S. 11/6/22 Assume high cost is what takes precedence
# - AHT: Use the high rate for days where there's a conflicting overlap.

class ReimbursementTest < Minitest::Test


  # Reimbursement for Set 1 should be $165
  SET_1 = [
    Project.new(:low_cost, Date.new(2015, 9, 01), Date.new(2015, 9, 03))
  ]

  # Reimbursement for Set 2 should be $590
  SET_2 = [
    Project.new(:low_cost, Date.new(2015, 9, 1), Date.new(2015, 9, 1)), # 45 (since it begins and ends on the same day)
    Project.new(:high_cost, Date.new(2015, 9, 2), Date.new(2015, 9, 6)), # 425 — the start and end are both full days
    Project.new(:low_cost, Date.new(2015, 9, 6), Date.new(2015, 9, 8)) # 165 - 45 = 120 (since it shares a travel day with the previous project)
  ]

  # Reimbursement for Set 3 should be $445
  SET_3 = [
    Project.new(:low_cost, Date.new(2015, 9, 1), Date.new(2015, 9, 3)), # 165
    Project.new(:high_cost, Date.new(2015, 9, 5), Date.new(2015, 9, 7)), # 225
    Project.new(:high_cost, Date.new(2015, 9, 8), Date.new(2015, 9, 8)) # 55
  ]

  # Reimbursement for Set 4 should be $185
  SET_4 = [
    Project.new(:low_cost, Date.new(2015, 9, 1), Date.new(2015, 9, 1)), # 45
    Project.new(:low_cost, Date.new(2015, 9, 1), Date.new(2015, 9, 1)), # 0 — because only one day should be reimbursed, even if there are multiple projects
    Project.new(:high_cost, Date.new(2015, 9, 2), Date.new(2015, 9, 2)), # 85 - because this should be treated as a full day
    Project.new(:high_cost, Date.new(2015, 9, 2), Date.new(2015, 9, 3)) # 55 — since the first day is being treated as a full day
  ]

  def test_set_1
    assert_equal 165, Reimbursement.new(SET_1).amount
  end

  def test_set_2
    assert_equal 590, Reimbursement.new(SET_2).amount
  end

  def test_set_3
    assert_equal 445, Reimbursement.new(SET_3).amount
  end

  def test_set_4
    assert_equal 185, Reimbursement.new(SET_4).amount
  end
end