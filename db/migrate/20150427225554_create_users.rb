class CreateUsers < ActiveRecord::Migration
  # This method determines the change to be made to the db
  def change
  	# this method accepts a block with one block variable (t)
  	# and uses the t object to create name and email columns in the db
    create_table :users do |t|
      # column name
      t.string :name
      # column name
      t.string :email

      t.timestamps null: false
    end
  end
end
