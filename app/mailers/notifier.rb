class Notifier < ActionMailer::Base
  default :from => "noreply@serialowyswiat.pl"
  
  def email_friend(video, sender_name, receiver_email)
    @video = video
    @sender_name = sender_name
    photo_name = @video.photo_file_name
    attachments["#{photo_name}"] = File.read(Rails.root.join("public/system/photos/#{@video.id}/thumbnails/#{photo_name}"))
    mail :to => receiver_email, :subject => "Interesting Video"
  end
 
  def copyright_violation(video, sender_name, sender_text)
    @video = video
    @sender_name = sender_name
    @sender_text = sender_text
    photo_name = @video.photo_file_name
    attachments["#{photo_name}"] = File.read(Rails.root.join("public/system/photos/#{@video.id}/thumbnails/#{photo_name}"))
    mail :to => "info@serialowyswiat.pl", :subject => "Copyright violation"
  end

  def comment_added(comment)
    @video = comment.video
    mail :to => @video.user.email, :subject => "New comment for '#{@video.title}'"
  end
  
  def video_added(video, user)
    @video = video
    photo_name = @video.photo_file_name
    attachments["#{photo_name}"] = File.read(Rails.root.join("public/system/photos/#{@video.id}/thumbnails/#{photo_name}"))
    mail :to => user.email, :subject => "Dear '#{user.email}'. New video was added '#{@video.title}'"
  end
end
