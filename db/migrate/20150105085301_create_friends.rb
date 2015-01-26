class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string :name
      t.string :uid
      t.belongs_to :friend, :class_name => 'User' , index: true
      t.timestamps
    end
  end
end
