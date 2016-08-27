class Province < ActiveRecord::Base
  belongs_to :department
  has_many :district
end
