class AddMainPageCheckboxToVideo < ActiveRecord::Migration
  def self.up
    add_column :videos, :mainpage, :boolean, :default => false
  end

  def self.down
    remove_column :videos, :mainpage
  end
end
