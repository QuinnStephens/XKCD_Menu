require 'spec_helper'

describe Menu do
  it  'has a valid factory' do
    FactoryGirl.create(:menu).should be_valid
  end
  it 'is invalid without a file' do
    FactoryGirl.build(:menu, {"file" => nil}).should_not be_valid
  end
  it 'is invalid without a properly formatted file' do
    bad_file = Rack::Test::UploadedFile.new(Rails.root.join("spec/files/sample_invalid.txt"), "text/plain")
    FactoryGirl.build(:menu, {"file" => bad_file}).should_not be_valid
  end
  it 'has a valid total after parsing the file' do
    menu = FactoryGirl.build(:menu)
    menu.parse_file
    menu.total.should eq 1505
  end
  it 'has a valid set of items after parsing the file' do
    menu = FactoryGirl.build(:menu)
    menu.parse_file
    expected_parsed_items = {"mixed fruit" => 215, "french fries" => 275, "side salad" => 335, "hot wings" => 355, "mozzarella sticks" => 420, "sampler plate" => 580 }
    menu.items.should eq expected_parsed_items
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