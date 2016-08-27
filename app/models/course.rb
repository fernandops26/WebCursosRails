class Course < ActiveRecord::Base
  belongs_to :category


  has_attached_file :imagen, styles: {thumb:"800x600",mini:"400x200"}
  validates_attachment_content_type :imagen, content_type: /\Aimage\/.*\Z/
end
