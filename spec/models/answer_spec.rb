require 'rails_helper'

RSpec.describe Answer do
  context 'answer record is invalid' do
    it 'should be invalid' do
      answer = described_class.new

      expect(answer.valid?).to be(false)
      expect(answer.errors.count).to eq(2)
      expect(answer.errors.full_messages).to include("Trivia question can't be blank", "Answer text can't be blank")
    end
  end

  context 'the answer is correct and trivia_question are valid' do
    let!(:trivia_question) { FactoryBot.build(:trivia_question, :with_incorrect_answer).save(validate: false) }
    let(:answer) { FactoryBot.create(:answer, correct: true, answer_text:'Elephant', trivia_question: TriviaQuestion.first )}
    context 'the answer is valid' do
      it 'should be valid' do
        expect(answer.valid?).to be(true)
        expect(answer.trivia_question.valid?).to be(true)
        expect(answer.errors.count).to eq(0)
      end
    end

    context '#retrieve_answer' do
      it 'should return the same record' do
        expect(answer.retrieve_answer).to eq(answer)
      end
    end
  end

  context 'the answer is incorrect and trivia_question is valid' do
    let!(:trivia_question) { FactoryBot.build(:trivia_question, :with_correct_answer).save(validate: false) }
    let(:answer) { FactoryBot.create(:answer, correct: false, answer_text:'Sloth', trivia_question: TriviaQuestion.first)}
    context 'the answer is valid' do
      it 'should be valid' do
        expect(answer.valid?).to be(true)
        expect(answer.trivia_question.valid?).to be(true)
        expect(answer.errors.count).to eq(0)
      end
    end

    context '#retrieve_answer' do
      it 'should return a different record' do
        expect(answer.retrieve_answer).not_to eq(answer)
      end
    end
  end



end