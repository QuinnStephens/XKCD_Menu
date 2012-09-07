require 'csv'

class Menu < ActiveRecord::Base
  attr_accessible :items, :total, :file

  serialize :items, Hash

  def self.parse_file(file)
    # Parse CSV format
    array = CSV.parse(file.read)
    # The first element is the total price we're trying to reach
    # Don't forget to remove the dollar sign
    total = array.shift.first.split('$').last.to_f
    # Convert to pennies, otherwise math gets messed up
    total *= 100;
    # Convert the nested arrays into a Hash for easier organization
    hash = {}
    array.each do |a|
      # Remove the dollar sign from the amounts
      a[1] = a[1].split('$').last.to_f
      # Convert to pennies
      a[1] = (a[1] * 100).to_i
      hash[a[0]] = a[1]
    end
    {:total => total, :items => hash}
  end

  def solve_for_total
    # Figure out which, if any, combination of items can add up to the total
    # First eliminate any items that are already more than the total
    items.delete_if {|item, price| price > total}
    # Sort the prices from smallest to largest
    items.values.sort!
    # Find how many of the cheapeast items you can add while <= total. This is the largest possible number of items
    cheapest = items.values.first
    max_item_count = (total / cheapest).floor
    i = 1
    until i > max_item_count
      # The array combination method will give us every possible combination of i members of a set
      # But each number is unique, so we need to add alternate versions of each number in order to allow for multiple
      # orders of the same item
      possible_items = []
      items.values.each do |val|
        i.times do
          possible_items.push(val)
        end
      end
      tests = possible_items.combination(i).to_a
      tests.each do |test|
        sum = test.inject{|sum, x| sum + x}
        puts "#{test} sum: #{sum}"
        return test if sum == total
      end
      i += 1
    end
  end
end