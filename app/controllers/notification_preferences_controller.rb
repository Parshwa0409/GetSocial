class NotificationPreferencesController < ApplicationController
  def create
    preference = NotificationPreference.create({preferred_user_id: get_preferred_user_id, preferred_notifier: active_user})
    
    if preference.save
      user = User.find(get_preferred_user_id)

      render partial:"shared/success", locals: {message: "Stay in the loop! You'll now receive notifications whenever a #{user.email} makes a new post."}
    else
      render partial:"error"
    end
  end

  def destroy
    preference = NotificationPreference.find_by(preferred_user_id: get_preferred_user_id, preferred_notifier: active_user)
    
    if preference.present?
      user = User.find(get_preferred_user_id)

      preference.destroy
      
      render partial:"shared/danger", locals: {message: "You have successfully unsubscribed from receiving notifications. You will no longer receive messages about new posts from #{user.email}."}
    else
      render partial:"shared/danger", locals: {message: "Oops! It seems something went wrong. Please try again."}
    end
    
  end

  private
  def get_preferred_user_id
    params[:preferred_user_id]
  end
end
