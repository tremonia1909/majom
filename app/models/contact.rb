class Contact < ActiveRecord::Base
  belongs_to :persons, :class_name => 'User'
  belongs_to :contacts, :class_name => 'User'
end
