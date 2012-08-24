class VideoObserver < ActiveRecord::Observer
 def after_save(video)
   @users = User.select("distinct user_id, email").joins(:categories).where('category_id IN (?)', video.category_ids)
   @users.each do |user|
     Notifier.video_added(video, user).deliver
   end
 end
end
