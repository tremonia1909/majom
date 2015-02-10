class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable


  has_many :user_packets
  has_many :packets, through: :user_packets
  has_many :user_projects
  has_many :projects, through: :user_projects

  has_many :comments
end
