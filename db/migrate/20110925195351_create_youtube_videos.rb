class CreateYoutubeVideos < ActiveRecord::Migration
  def self.up
    create_table :youtube_videos do |t|
      t.string :title
      t.string :description
      t.string :yt_video_embed

      t.timestamps
    end
  end

  def self.down
    drop_table :youtube_videos
  end
end
