class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:index, :show, :add_admin, :remove_admin, :edit_add_avatar, :update_add_avatar]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  def edit_add_avatar
    @user = current_user
    respond_to do |format|
      format.html
      format.xml { render :xml => @user }
    end
  end
 
  def update_add_avatar
    @user = current_user
    respond_to do |format|
    if @user.update_attributes(params[:user])
      format.html { redirect_to(@user, :notice => 'Avatar was successfully added.') }
      format.xml { head :ok }  
    else
      format.html { render :action => "add_avatar" }
      format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
    end
    end
  end
 
  def add_admin
    @user = User.find(params[:id])
    @user.update_attribute :admin, true
    respond_to do |format|
      format.js { @user }
    end
  end
 
  def remove_admin
    @user = User.find(params[:id])
    @user.update_attribute :admin, false
    respond_to do |format|
      format.js { @user }
    end
  end
end
