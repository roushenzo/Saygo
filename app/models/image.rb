class Image < ActiveRecord::Base
  belongs_to :page
  mount_uploader :file, ImageUploader
end
