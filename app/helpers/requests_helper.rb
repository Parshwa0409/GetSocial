module RequestsHelper
  def render_request_button_if_user_not_blocked(user)
    unless active_user.blocked?(user)
      yield
    end
  end

  def render_follow_button(user)
    if !active_user.following?(user) && !active_user.sent_follow_request_to?(user) 
      yield
    end
  end

  def render_cancel_request_button(user)
    if active_user.sent_follow_request_to?(user)
      yield
    end
  end

  def render_unfollow_button(user)
    if active_user.following?(user)
      yield
    end
  end
end
