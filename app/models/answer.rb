class Answer < ApplicationRecord
  belongs_to :trivia_question, optional: true

  validates :trivia_question, presence: true
  validates :answer_text, presence: true, length: { maximum: 255 } #Not going to check for uniqueness cause two users can submit the same question


  def retrieve_answer
    return self if self.correct?
    Answer.find_by(correct: true, trivia_question_id: self.trivia_question_id)
  end
end
