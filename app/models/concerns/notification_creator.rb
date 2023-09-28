module NotificationCreator
  def create_notification
    Notification.create!(user: post.user, action: self, action_type: self.class.name )
  end
end