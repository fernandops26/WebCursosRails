class Coordinator < ActiveRecord::Base
	 mount_uploader :curriculum , DocumentUploader
end
