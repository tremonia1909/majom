class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true

  validates :resource_type, :inclusion => { :in => Rolify.resource_types }

  scopify

  has_many :user_packets
  has_many :packets, through: :user_packets
  has_many :user_projects
  has_many :projects, through: :user_projects

end
