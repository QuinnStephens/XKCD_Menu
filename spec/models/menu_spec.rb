require 'spec_helper'

describe Menu do
  it  'has a valid factory' do
    FactoryGirl.create(:menu).should be_valid
  end
  it 'is invalid without a file' do
    FactoryGirl.build(:menu, {"file" => nil}).should_not be_valid
  end
  it 'returns false if there is no solution' do
    menu = FactoryGirl.build(:menu, {"total" => 1000, "items" => {"bread" => 160, "butter" => 1200}})
    menu.solve_for_total.should eq false
  end
  it 'returns a solution if there is one' do
    FactoryGirl.build(:menu, {"total" => 1000, "items" => {"bread" => 175, "butter" => 300}}).solve_for_total.should_not eq false
  end
  it 'returns a solution that adds up to the correct total' do
    menu = FactoryGirl.build(:menu, {"total" => 1000, "items" => {"bread" => 175, "butter" => 300}})
    sum = 0
    menu.solve_for_total.each do |item|
      sum += menu.items[item]
    end
    sum.should eq menu.total
  end
end