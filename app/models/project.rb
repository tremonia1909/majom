class Project < ActiveRecord::Base
  has_many :packets
  has_many :user_projects
  has_many :users, through: :user_projects



end