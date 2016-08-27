class District < ActiveRecord::Base
  belongs_to :province
  belongs_to :person
end
