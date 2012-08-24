class AddPublishedAndMainPageToYoutubeVideo < ActiveRecord::Migration
  def self.up
    add_column :youtube_videos, :mainpage, :boolean, :default => false
    add_column :youtube_videos, :published, :boolean, :default => false
  end

  def self.down
    remove_column :youtube_videos, :mainpage
    remove_column :youtube_videos, :published
  end
end
