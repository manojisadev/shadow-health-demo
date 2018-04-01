FactoryBot.define do
  factory :trivia_question do
    question 'Which is the only mammal that can’t jump?'
    association :user

    after(:build) do |question|
      question.answers << FactoryBot.create(:answer, trivia_question: question, answer_text:'Bear')
      question.answers << FactoryBot.create(:answer, trivia_question: question, answer_text:'Rodent')
    end

    trait :with_correct_answer do
      after(:build) do |question|
        question.answers << FactoryBot.create(:answer, trivia_question: question, answer_text:'Elephant', correct: true)
      end
    end

    trait :with_incorrect_answer do
      after(:build) do |question|
        question.answers << FactoryBot.create(:answer, trivia_question: question, answer_text:'Sloth')
      end
    end
  end
end

