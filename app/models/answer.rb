class Answer < ApplicationRecord
  belongs_to :trivia_question, optional: true

  def retrieve_answer
    return self if self.correct?
    Answer.find_by(correct: true, trivia_question_id: self.trivia_question_id)
  end
end
