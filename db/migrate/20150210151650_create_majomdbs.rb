class CreateMajomdbs < ActiveRecord::Migration
  def change


    create_table :projects do |t|

      t.string  :project_name
      t.date    :start_date
      t.date    :deadline
      t.string  :description
      t.decimal  :budget
      t.float  :progress
      t.timestamps null: false

    end
    create_table :packets do |t|

      t.belongs_to :projects, index:true
      t.string  :packet_name
      t.date    :start_date
      t.date    :deadline
      t.integer :status
      t.string  :description
      t.float   :expenses
      t.integer :predecessor
      t.integer :successor
      t.timestamps null: false

    end


    create_table :user_packets, :id => false do |t|
      t.belongs_to :users
      t.belongs_to :packets
      t.integer :users_roles

    end

    create_table :user_projects, :id => false do |t|
      t.belongs_to :users
      t.belongs_to :projects
      t.integer :users_roles
    end

    create_table :comments do |t|
      t.string  :comment
      t.belongs_to :packets
      t.belongs_to :users

    end


  end
end