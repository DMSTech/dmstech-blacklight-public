class AddParkerImageAccessToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :parker_image_access, :integer
  end

  def self.down
    remove_column :users, :parker_image_access
  end
end
