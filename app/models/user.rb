class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :user_packets
  has_many :packets, through: :user_packets
  has_many :user_projects
  has_many :projects, through: :user_projects

  has_many :persons, :class_name => 'contact', :foreign_key => 'persons_id'
  has_many :contacts, :class_name => 'contact', :foreign_key => 'contacts_id'


  has_many :comments
end
