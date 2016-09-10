class Institution < ActiveRecord::Base
	 has_many :programations
	 accepts_nested_attributes_for :programations

	 has_attached_file :imagen, styles: {mini:"400x400"}
	 validates_attachment_content_type :imagen, content_type: /\Aimage\/.*\Z/
end
