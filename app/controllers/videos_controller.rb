# encoding: utf-8
class VideosController < ApplicationController
  layout :choose_layout
  before_filter :authenticate_user!, :only => [:new, :create, :update, :edit, :destroy, :admin, :list_your_video]
  # GET /videos
  # GET /videos.xml
  def notify_friend
    @video = Video.find(params[:id])
    Notifier.email_friend(@video, params[:name], params[:email]).deliver
    redirect_to @video, :notice => "Wiadomość została wysłana do znajomego"
  end
  
  def copyright_violation
    @video = Video.find(params[:id])
    Notifier.copyright_violation(@video, params[:name], params[:text]).deliver
    redirect_to @video, :notice => "Dziękujemy za wysłanie do nas wiadomości. Postaramy się odpowiedzieć najszybciej jak to tylko możliwe"
  end
  
  def tag
    @videos = Video.tagged_with(params[:id]).where(:published => true).paginate(:page => params[:page], :per_page => 30)
    @tags = Video.tag_counts_on(:tags)
    render :action => 'index'
  end
  
  def index
    if params[:category_id] == '32'
      category = Category.find(params[:category_id])
      @youtube_videos = category.youtube_videos.where(:published => true).order("created_at ASC").paginate(:page => params[:page], :per_page => 30)
      @category_id = params[:category_id]
      @category_name = Category.find(@category_id).name
      @root_name = Category.find(@category_id).root.name
      respond_to do |format|
        format.html #index.html.erb
        format.xml { render :xml => @videos }
      end
    elsif params[:category_id]
      category = Category.find(params[:category_id])
      @videos = category.videos.where(:published => true).order("published_at DESC").paginate(:page => params[:page], :per_page => 30)
      @category_id = params[:category_id]
      @category_name = Category.find(@category_id).name
      @root_name = Category.find(@category_id).root.name
      respond_to do |format|
        format.html #index.html.erb
        format.xml { render :xml => @videos }
      end   
    else
      @videos = Video.where(:published => true, :mainpage => true).order("published_at DESC").paginate(:page => params[:page], :per_page => 30)
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @videos }
      end
    end
  end 
  
  def feed
    @videos = Video.where(:published => true).order("published_at DESC").limit(20)
    respond_to do |format|
      format.atom
    end
  end
 
 def admin
    if current_user.try(:admin?)
    @videos = Video.order("published_at DESC").paginate(:page => params[:page], :per_page => 100)

    respond_to do |format|
      format.html # admin.html.erb
      format.xml { render :xml => @videos }
    end
    else
    redirect_to root_path, :notice => 'Nie masz dotepu do tej strony'  
    end
  end

  def list_your_videos
    if current_user
    @videos = current_user.videos.order("published_at").paginate(:page => params[:page], :per_page => 30)

    respond_to do |format|
      format.html #list_your_video
      format.xml { render :xml => @videos }
    end
    else
    redirect_to new_user_session_path, :notice => 'Musisz być zalogowany aby obejrzeć swoje dodane Filmy i Seriale'
    end
  end
  # GET /videos/1
  # GET /videos/1.xml
  def show
    #@video = Video.find_by_id_and_published(params[:id], true)
    @video = Video.find(params[:id])
    Video.increase_hits_counter(@video.id)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @video }
    end
  end
  
  # GET /videos/new
  # GET /videos/new.xml
  def new
    @video = Video.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @video }
    end
  end

  # GET /videos/1/edit
  def edit
    if current_user.try(:admin?)
     @video = Video.find(params[:id])
     respond_to do |format|
       format.html #edit.html.erb
       format.xml { render :xml => @video }
     end
    else
     @video = current_user.videos.find(params[:id])     
     respond_to do |format|
       format.html #edit.html.erb
       format.xml { render :xml => @video} 
     end
    end
  end

  # POST /videos
  # POST /videos.xml
  def create
    @video = current_user.videos.new(params[:video])
    Video.set_hits_counter(@video.id)
    respond_to do |format|
      if @video.save
        format.html { redirect_to(@video, :notice => 'Serial lub Film został poprawnie dodany') }
        format.xml  { render :xml => @video, :status => :created, :location => @video }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
      end
    end
  end

  def similar
      @similar = Video.find(params[:id])
      @video = @similar.dup
      @video.comments.destroy_all
      respond_to do |format|
         format.html #similar.html.erb
         format.xml { render :xml => @video }
      end
   end

   def create_similar
      @video = current_user.videos
      Video.set_hits_counter(@video.id)
      respond_to do |format|
        if @video.save
	  format.html { redirect_to(@video, :notice => 'Serial lub Film został poprawnie dodany.') }
	  format.xml  { render :xml => @video, :status => :created, :location => @video }
        else
          format.html { render :action => "new" }
	  format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
	end
      end
    end

  # PUT /videos/1
  # PUT /videos/1.xml
  def update
    @video = Video.find(params[:id])

    respond_to do |format|
      if @video.update_attributes(params[:video])
        format.html { redirect_to(@video, :notice => 'Serial lub Film został poprawiony.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.xml
  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    respond_to do |format|
      format.html { redirect_to(videos_admin_url, :notice => 'Serial lub Film został usunięty.') }
      format.xml  { head :ok }
    end
  end
  private

  def choose_layout
    case action_name
    when "index"
      "main_page"
    else
      "application"
    end
  end

end
