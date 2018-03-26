class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def sign_out(*args)
    update_streak_score(delete_session = true)
    super
  end

  def update_streak_score(delete_session = false)
    return unless current_user && session[:streak_count]
    current_user.update_attributes(streak: session[:streak_count]) if session[:streak_count] > current_user.streak
    delete_session ? session.delete(:streak_count) : session[:streak_count] = 0
  end
end
