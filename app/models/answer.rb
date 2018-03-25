class Answer < ApplicationRecord
  belongs_to :trivia_question, optional: true
end
