class Project < ActiveRecord::Base
  attr_accessible :all
  has_many :packets
  has_many :user_projects
  has_many :role, through: :user_projects
  has_many :users, through: :user_projects

  def create_project
    @project = Project.new
  end
end