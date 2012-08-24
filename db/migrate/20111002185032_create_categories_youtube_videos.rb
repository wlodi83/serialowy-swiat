class CreateCategoriesYoutubeVideos < ActiveRecord::Migration
  def self.up
    create_table :categories_youtube_videos, :id => false do |t|
      t.references :category
      t.references :youtube_video
    end
  end

  def self.down
    drop_table :categories_youtubevideos
  end
end
