FactoryBot.define do
  factory :answer do
    answer_text 'Oxygen'
    correct false
    association :trivia_question
  end
end

