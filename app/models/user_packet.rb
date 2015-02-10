class UserPacket < ActiveRecord::Base
  attr_accessible :all
  belongs_to :user
  belongs_to :packet
  belongs_to :role
end