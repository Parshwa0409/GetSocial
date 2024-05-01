module ProfileHelper
  def render_share_profile_button_if_following(user)
    if active_user.following?(user) || active_user.myself?(user)
      yield
    end
  end

  def render_profile_buttons_if_my_profile(user)
    if active_user.myself?(user)
      yield
    end
  end

  def render_request_buttons_if_not_my_profile(user)
    unless active_user.myself?(user)
      yield
    end
  end

  def render_profile_posts_if_user_follows_me(user)
    if active_user.following?(user) || active_user.myself?(user)
      yield
    end
  end

  # TODO: RENDER UNKOWN USER
  def render_unknown_user_if_blocked
    if active_user.blocked?(user)
      yield
    end
  end

end
