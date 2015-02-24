class Packet < ActiveRecord::Base
  enum status: [:task, :working, :finished, :problem]
  belongs_to :project
  has_many :comments
  has_many :user_packets
  has_many :users, through: :user_packets
  has_many :roles, through: :user_packets
end