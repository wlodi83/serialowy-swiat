class CreateCategoriesVideos < ActiveRecord::Migration
  def self.up
    create_table :categories_videos, :id => false do |t|
      t.references :category
      t.references :video
    end
  end

  def self.down
    drop_table :categories_videos
  end
end
