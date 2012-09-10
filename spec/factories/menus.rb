FactoryGirl.define do
  factory  :menu do |f|
    f.file Rack::Test::UploadedFile.new(Rails.root.join("spec/files/sample.txt"), "text/plain")
  end
end