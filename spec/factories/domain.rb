FactoryGirl.define do
  factory :domain, class: CspReports::Domain do
    name { FFaker::Internet.domain_word }
    url { FFaker::Internet.uri("https") }
  end
end
