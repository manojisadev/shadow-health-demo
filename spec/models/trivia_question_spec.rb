require 'rails_helper'

RSpec.describe TriviaQuestion do
  context 'trivia question lacks answers & valid answer' do
    it 'should have 5 errors' do
      #TODO Refactor this with shoulda-matcher
      trivia_question = described_class.new

      expect(trivia_question.valid?).to be(false)
      expect(trivia_question.errors.count).to eq(5)
      expect(trivia_question.errors.full_messages).to include("User must exist", "User can't be blank",
                                                     "Question can't be blank", "Answers must have at least one correct answer",
                                                     "Answers must have exactly four answers")
    end

    context 'trivia question has 4 answers & 1 valid answer' do
      let(:trivia_question) { FactoryBot.create(:trivia_question, :with_correct_answer, :with_incorrect_answer) }
      it 'should be valid' do
        expect(trivia_question.valid?).to be(true)
        expect(trivia_question.errors.count).to eq(0)
      end
    end
  end
end