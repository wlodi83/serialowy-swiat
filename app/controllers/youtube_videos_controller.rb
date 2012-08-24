# encoding: utf-8
class YoutubeVideosController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :update, :edit, :destroy]
  # GET /youtube_videos
  # GET /youtube_videos.xml
  def index
    @youtube_videos = YoutubeVideo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @youtube_videos }
    end
  end

  # GET /youtube_videos/1
  # GET /youtube_videos/1.xml
  def show
    @youtube_video = YoutubeVideo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @youtube_video }
    end
  end

  # GET /youtube_videos/new
  # GET /youtube_videos/new.xml
  def new
    @youtube_video = YoutubeVideo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @youtube_video }
    end
  end

  # GET /youtube_videos/1/edit
  def edit
    @youtube_video = YoutubeVideo.find(params[:id])
  end

  # POST /youtube_videos
  # POST /youtube_videos.xml
  def create
    @youtube_video = YoutubeVideo.new(params[:youtube_video])

    respond_to do |format|
      if @youtube_video.save
        format.html { redirect_to(@youtube_video, :notice => 'Youtube video was successfully created.') }
        format.xml  { render :xml => @youtube_video, :status => :created, :location => @youtube_video }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @youtube_video.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /youtube_videos/1
  # PUT /youtube_videos/1.xml
  def update
    @youtube_video = YoutubeVideo.find(params[:id])

    respond_to do |format|
      if @youtube_video.update_attributes(params[:youtube_video])
        format.html { redirect_to(@youtube_video, :notice => 'Youtube video was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @youtube_video.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /youtube_videos/1
  # DELETE /youtube_videos/1.xml
  def destroy
    @youtube_video = YoutubeVideo.find(params[:id])
    @youtube_video.destroy

    respond_to do |format|
      format.html { redirect_to(youtube_videos_url) }
      format.xml  { head :ok }
    end
  end
end
