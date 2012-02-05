class Comment < ActiveRecord::Base
  #belongs_to :commentable, :polymorphic => true
  belongs_to :page
  default_scope :order => "created_at DESC"

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, :presence => true,
            :format => {:with => email_regex}
  validates_presence_of :user_name
  validates_presence_of :description


end
