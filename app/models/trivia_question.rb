class TriviaQuestion < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: :all_blank

  validates :user, presence: true
  validates :question, presence: true, length: { maximum: 255 } #Not going to check for uniqueness cause two users can submit the same question
  validate :validate_correct_answers, :validate_answer_count

  NUMBER_OF_ANSWERS = 4

  def validate_correct_answers
    correct_answers = self.answers.count {|answer| answer.correct == true }
    errors.add(:answers, "must have at #{correct_answers > 1 ? 'most':'least'} one correct answer") unless correct_answers == 1
  end

  def validate_answer_count
    errors.add(:answers, 'must have exactly four answers') unless self.answers.length == NUMBER_OF_ANSWERS
  end
end
