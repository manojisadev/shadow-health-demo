class AnswersController < ApplicationController
  def check
    @user_answer = Answer.find(params[:answer_id])
    #TODO switch update_attributes with incremnt and decrement
    @user_answer.correct ? current_user.update_attributes({score: current_user.score + 4}) : current_user.update_attributes({score: current_user.score - 1})

    redirect_to trivia_question_answer_path(@user_answer.trivia_question_id, @user_answer)
  end

  def show
    @user_answer = Answer.find(params[:id])
  end
end
