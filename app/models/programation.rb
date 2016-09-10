class Programation < ActiveRecord::Base
  belongs_to :institution
  belongs_to :course
  has_many :subsidiaries
  has_many :programations , :through => :subsidiaries




  has_and_belongs_to_many :modalities
  accepts_nested_attributes_for :modalities


end
