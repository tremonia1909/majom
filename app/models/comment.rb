class Comment < ActiveRecord::Base
  attr_accessible :all
  belongs_to :packet
  belongs_to :user
end