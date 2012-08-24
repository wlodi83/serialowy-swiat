class AddSeasonAndEpisodeToVideo < ActiveRecord::Migration
  def self.up
    add_column :videos, :episode, :integer
    add_column :videos, :season, :integer
  end

  def self.down
    remove_column :videos, :episode
    remove_column :videos, :season
  end
end
