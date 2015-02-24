class CreateContacts < ActiveRecord::Migration
  def change

    create_table :contacts, :id => false do |t|
      t.references :persons
      t.references :contacts
    end

  end
end
