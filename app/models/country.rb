class Country < ActiveRecord::Base
  has_many :pages
  has_many :cities
  validates :name, :presence => true, :uniqueness => true
  validates :flag, :presence => true
  mount_uploader :flag, FlagUploader
end
