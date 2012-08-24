class ChangeYtVideoEmbedFromStringToText < ActiveRecord::Migration
  def self.up
    change_column :youtube_videos, :yt_video_embed, :text
  end

  def self.down
    change_column :youtube_videos, :yt_video_embed, :string
  end
end
