class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :phone
      t.text :phone_content
      t.string :email
      t.text :email_content

      t.timestamps
    end
  end
end
