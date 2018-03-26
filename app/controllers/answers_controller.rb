class AnswersController < ApplicationController
  before_action :authenticate_user!

  def check
    session[:streak_count] ||= 0

    @user_answer = Answer.find(params[:answer_id])
    #TODO switch update_attributes with incremnt and decrement
    if @user_answer.correct?
      current_user.update_attributes({score: current_user.score + 4})
      session[:streak_count] += 1
    else
      current_user.update_attributes({score: current_user.score - 1})
      update_streak_score #inherited from ApplicationController
    end
    redirect_to trivia_question_answer_path(@user_answer.trivia_question_id, @user_answer)
  end

  def show
    @user_answer = Answer.find(params[:id])
  end

  def destroy
    update_streak_score(delete_session = true)
    redirect_to root_path, notice: 'You have finished your game session!'
  end
end
