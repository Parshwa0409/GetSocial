module NotificationPreferencesHelper
  def render_subscribe_btn(preferred_user)
    notification_preference = get_notification_preference(preferred_user)
    if notification_preference.nil? && active_user.following?(preferred_user)
      yield
    end
  end

  def render_unsubscribe_btn(preferred_user)
    notification_preference = get_notification_preference(preferred_user)
    if notification_preference && active_user.following?(preferred_user)
      yield
    end
  end

  def get_notification_preference(preferred_user)
    NotificationPreference.find_by(preferred_user_id: preferred_user.id, preferred_notifier_id: active_user.id)
  end
end

