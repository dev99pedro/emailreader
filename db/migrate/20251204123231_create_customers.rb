class CreateCustomers < ActiveRecord::Migration[8.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :tel
      t.string :code
      t.string :subject


    end
  end
end
