class CreateMajomdbs < ActiveRecord::Migration
  def change


    create_table :projects do |t|

      t.string  :project_name
      t.date    :datum_start
      t.date    :datum_end
      t.string  :description
      t.float  :budget
      t.float  :process_status
      t.timestamps null: false

    end
    create_table :packets do |t|

      t.belongs_to :projects, index:true
      t.string  :packet_name
      t.date    :date_start
      t.date    :date_end
      t.integer :description_status
      t.string  :description
      t.float  :costs
      t.integer :packet_before
      t.integer :packet_after
      t.timestamps null: false

    end


    create_table :user_packets, :id => false do |t|
      t.belongs_to :users
      t.belongs_to :packets
      t.belongs_to :users_roles

    end

    create_table :user_projects, :id => false do |t|
      t.belongs_to :users
      t.belongs_to :projects
      t.belongs_to :users_roles

    end

    create_table :comments, :id => false do |t|
      t.primary_key :comment_id
      t.string  :comment
      t.belongs_to :packets
      t.belongs_to :users

    end


  end
end