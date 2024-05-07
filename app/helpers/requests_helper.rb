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

  def render_content_if_no_blocked_users(blocked_users_count)
    if blocked_users_count == 0 
      yield
    end
  end

  def render_blocked_users(blocked_users_count)
    unless blocked_users_count == 0 
      yield
    end
  end

  def render_requests_if_available(request_count)
    if request_count > 0 
        yield
    end
  end

  def render_content_if_available(request_count)
    unless request_count > 0 
        yield
    end
  end


  def remove_connections_if_any(user)

    if active_user.mutual_following_with?(user)
      active_user.unfollow(user)
      user.unfollow(active_user)
    elsif active_user.following?(user)
        active_user.unfollow(user)
    elsif user.following?(active_user)
        user.unfollow(active_user)
    end
    
  end

end
