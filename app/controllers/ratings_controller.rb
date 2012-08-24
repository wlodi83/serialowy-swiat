class RatingsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @video = Video.find_by_id(params[:video_id])
    if current_user.ratings.find_by_video_id(@video.id) 
      respond_to do |format|
      format.html { redirect_to video_path(@video), :notice => 'You canot rate for your own video' }
      format.js
      end
    else
      @rating = Rating.new(params[:rating])
      @rating.video_id = @video.id
      @rating.user_id = current_user.id
      if @rating.save
        respond_to do |format|
          format.html { redirect_to video_path(@video), :notice => 'Your rating has been saved' }
          format.js
        end
      end
    end
  end
  
  def update
    @video = Video.find_by_id(params[:video_id])
    if current_user.id == @video.id
      redirect_to video_path(@video), :alert => "You cannot rate for your own photo"
    else
      @rating = current_user.ratings.find_by_video_id(@video.id)
      if @rating.update_attributes(params[:rating])
        respond_to do |format|
          format.html { redirect_to video_path(@video), :notice => "Your rating has been updated" }
          format.js
        end
      end
    end
  end
end
