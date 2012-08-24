class ChangeColumnDescriptionInYoutubeVideosToTextColumnFromString < ActiveRecord::Migration
  def self.up
    change_column :youtube_videos, :description, :text
  end

  def self.down
    change_column :youtube_videos, :description, :string
  end
end
