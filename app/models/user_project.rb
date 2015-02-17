class UserProject < ActiveRecord::Base
  attr_accessible :all
  belongs_to :user
  belongs_to :project
  belongs_to :role
end