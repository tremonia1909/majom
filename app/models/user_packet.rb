class UserPacket < ActiveRecord::Base
  enum users_roles: [:manager, :member]
  belongs_to :user
  belongs_to :packet
  #belongs_to :role


  

end