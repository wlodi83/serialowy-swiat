class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!, :only => [:index, :add_subscription, :remove_subscription]
  def index
    @categories = Category.roots
    @count_of_subscriptions = current_user.categories.size
  end
  def add_subscription
    @subscription = Category.find(params[:id])
    current_user.categories << @subscription
    @count_of_subscriptions = current_user.categories.size
    respond_to do |format|
      format.js { @subscription }
    end
  end
  def remove_subscription
    @subscription = Category.find(params[:id])
    current_user.categories.delete(@subscription)
    @count_of_subscriptions = current_user.categories.size
    respond_to do |format|
      format.js { @subscription }
    end
  end
end
