class ChangeColumnSeasonInVideos < ActiveRecord::Migration
  def self.up
    rename_column :videos, :season, :season_id
  end

  def self.down
    rename_column :videos, :season_id, :season
  end
end
