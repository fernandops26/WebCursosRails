class Institution < ActiveRecord::Base
	 has_attached_file :imagen, styles: {mini:"400x400"}
	 validates_attachment_content_type :imagen, content_type: /\Aimage\/.*\Z/
end
