class Person < ActiveRecord::Base
  has_one :department
  belongs_to :user
end
