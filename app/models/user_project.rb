class UserProject < ActiveRecord::Base
  enum users_roles: [:manager, :member]
  belongs_to :user
  belongs_to :project
  #belongs_to :role


end