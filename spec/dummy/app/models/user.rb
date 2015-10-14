class User < ActiveRecord::Base
  has_many :domains, class_name: "CspReports::Domain"
end
