class NotificationPreferencesController < ApplicationController
  def create
    preference = NotificationPreference.create({preferred_user_id: get_preferred_user_id, preferred_notifier: active_user})
    if preference.save
      user = User.find(get_preferred_user_id)
      render partial:"success_subscribe", locals: {user: user}
    else
      render partial:"error"
    end
  end

  def destroy
    preference = NotificationPreference.find_by(preferred_user_id: get_preferred_user_id, preferred_notifier: active_user)

    if preference.present?
      user = User.find(get_preferred_user_id)
      preference.destroy
      render partial:"success_unsubscribe", locals: {user: user}
    else
      render partial:"error"
    end
  end

  private
  def get_preferred_user_id
    params[:preferred_user_id]
  end
end
