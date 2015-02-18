
class Packet < ActiveRecord::Base
  belongs_to :project
  has_many :comments
  has_many :user_packets
  has_many :users, through: :user_packets
  has_many :roles, through: :user_packets
end