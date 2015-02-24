class Comment < ActiveRecord::Base
  belongs_to :packet
  belongs_to :user
end