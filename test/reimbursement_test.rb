require 'minitest/autorun'
require 'date'
require_relative '../lib/reimbursement'

# ---The Rules---
# First day and last day of a project, or sequence of projects, is a travel day.
# - R.S. 11/6/22 What if a project starts and ends on the same day? Is it a travel day?
# - R.S. 11/6/22 Assume YES until told otherwise
# Any day in the middle of a project, or sequence of projects, is considered a full day.
# - R.S. 11/5/22 Does this mean that days between projects in the same set should be reimbursed as well?
# — R.S. 11/6/22 Assume NO until otherwise.
# If there is a gap between projects, then the days on either side of that gap are travel days.
# - R.S. 11/5/22 Is this just another way of stating that the first and last days of a project are travel days?
# - R.S. 11/6/22 Assume YES until told otherwise.
# If two projects push up against each other, or overlap, then those days are full days as well.
# - R.S. 11/5/22 Does this mean that days which would normally be 'travel days' should be reimbursed as full days?
# - R.S. 11/6/22 Assume YES until told otherwise.
# Any given day is only ever counted once, even if two projects are on the same day.
# A travel day is reimbursed at a rate of 45 dollars per day in a low cost city.
# A travel day is reimbursed at a rate of 55 dollars per day in a high cost city.
# A full day is reimbursed at a rate of 75 dollars per day in a low cost city.
# A full day is reimbursed at a rate of 85 dollars per day in a high cost city.
# - R.S. 11/5/22 If two projects, one low cost and the other high cost, start and end on the same day,
# - which reimbursement rate (high or low cost) should supersede the other?
# - R.S. 11/6/22 Assume high cost is what takes precedence

class ReimbursementTest < Minitest::Test


  # Reimbursement for Set 1 should be $165
  SET_1 = [
    Project.new(:low_cost, Date.new(2015, 9, 01), Date.new(2015, 9, 03))
  ]

  # Reimbursement for Set 2 should be $530
  SET_2 = [
    Project.new(:low_cost, Date.new(2015, 9, 1), Date.new(2015, 9, 1)), # 45 (since it begins and ends on the same day)
    Project.new(:high_cost, Date.new(2015, 9, 2), Date.new(2015, 9, 6)), # 365
    Project.new(:low_cost, Date.new(2015, 9, 6), Date.new(2015, 9, 8)) # 165 - 45 = 120 (since it shares a travel day with the previous project)
  ]

  SET_3 = [
    Project.new(:low_cost, Date.new(2015, 9, 1), Date.new(2015, 9, 3)),
    Project.new(:high_cost, Date.new(2015, 9, 5), Date.new(2015, 9, 7)),
    Project.new(:high_cost, Date.new(2015, 9, 8), Date.new(2015, 9, 8))
  ]

  SET_4 = [
    Project.new(:low_cost, Date.new(2015, 9, 1), Date.new(2015, 9, 1)),
    Project.new(:low_cost, Date.new(2015, 9, 1), Date.new(2015, 9, 1)),
    Project.new(:high_cost, Date.new(2015, 9, 2), Date.new(2015, 9, 2)),
    Project.new(:high_cost, Date.new(2015, 9, 2), Date.new(2015, 9, 3))
  ]

  def test_set_1
    assert_equal 165, Reimbursement.new(SET_1).amount
  end

  def test_set_2
    assert_equal 530, Reimbursement.new(SET_2).amount
  end
end