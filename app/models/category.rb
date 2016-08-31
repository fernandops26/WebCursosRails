class Category < ActiveRecord::Base
  has_many :courses

  has_attached_file :imagen, styles: {mini:"400x400"}
  validates_attachment_content_type :imagen, content_type: /\Aimage\/.*\Z/

  after_initialize :set_defaults

  private
  def set_defaults
    if self.new_record?
      self.destacar ||= false
    end
  end
end
