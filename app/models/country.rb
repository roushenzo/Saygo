class Country < ActiveRecord::Base
  default_scope order('name')
  has_many :pages
  has_many :cities
  validates :name, :presence => true, :uniqueness => true
  validates :flag, :presence => true
  mount_uploader :flag, FlagUploader
end
