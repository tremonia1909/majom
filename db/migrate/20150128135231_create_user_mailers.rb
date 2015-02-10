class CreateUserMailers < ActiveRecord::Migration
  def change
    create_table :user_mailers do |t|

      t.timestamps
    end
  end
end
