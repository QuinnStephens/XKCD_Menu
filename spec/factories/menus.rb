FactoryGirl.define do
  random_total = (rand * 1500).to_i  # Things slow down a lot when the total is higher than $15 so we limit it to that
  random_items = {"sammich" => (rand * 1000).to_i, "soup" => (rand * 1000).to_i, "grits" => (rand * 1000).to_i}
  factory  :menu do |f|
    f.total random_total
    f.items random_items
  end
end