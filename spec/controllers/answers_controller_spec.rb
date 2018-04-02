require 'rails_helper'

RSpec.describe AnswersController, :type => :controller do
  context '#check' do
    context 'logged in as user and answers question with an answer' do
      let!(:user) {FactoryBot.create(:user, email: 'testuser@example.com', score: 0)}
      before(:each) do
        sign_in user
      end
      context 'correct answer' do
        let!(:trivia_question) {FactoryBot.build(:trivia_question, :with_incorrect_answer).save(validate: false)}
        let(:answer) {FactoryBot.create(:answer, correct: true, answer_text: 'Elephant', trivia_question: TriviaQuestion.first)}


        before do
          post :check, {params:
                            {
                                answer_id: answer.id,
                                trivia_question_id: answer.trivia_question.id
                            }
          }
        end

        it 'redirects to show page, increases user score & session streak_count' do
          expect(response.content_type).to eq("text/html")
          expect(response.status).to eq(302)
          expect(response).to redirect_to(trivia_question_answer_path(answer.trivia_question.id, answer))

          user.reload
          expect(user.score).to eq(4)
          expect(session[:streak_count]).to eq(1)
        end
      end

      context 'incorrect answer' do
        let!(:trivia_question) {FactoryBot.build(:trivia_question, :with_correct_answer).save(validate: false)}
        let(:answer) {FactoryBot.create(:answer, correct: false, answer_text: 'Sloth', trivia_question: TriviaQuestion.first)}

        before do
          post :check, {params:
                            {
                                answer_id: answer.id,
                                trivia_question_id: answer.trivia_question.id
                            }
          }
        end

        it 'redirects to show page, decreases user score (default 0) & session streak_count' do
          expect(response.content_type).to eq("text/html")
          expect(response.status).to eq(302)
          expect(response).to redirect_to(trivia_question_answer_path(answer.trivia_question.id, answer))

          user.reload
          expect(user.score).to eq(0)
          expect(session[:streak_count]).to eq(0)
        end
      end
    end

    context 'user with streak 1, score 8, session streak 2' do
      let!(:user) {FactoryBot.create(:user, email: 'testuser@example.com', score: 8, streak: 1)}
      before(:each) do
        session[:streak_count] = 2
        sign_in user
      end
      context 'incorrect answer' do
        let!(:trivia_question) {FactoryBot.build(:trivia_question, :with_correct_answer).save(validate: false)}
        let(:answer) {FactoryBot.create(:answer, correct: false, answer_text: 'Sloth', trivia_question: TriviaQuestion.first)}

        before do
          post :check, {params:
                            {
                                answer_id: answer.id,
                                trivia_question_id: answer.trivia_question.id
                            }
          }
        end

        it 'redirects to show page, decreases user score (default 0) & session streak_count' do
          expect(response.content_type).to eq("text/html")
          expect(response.status).to eq(302)
          expect(response).to redirect_to(trivia_question_answer_path(answer.trivia_question.id, answer))

          user.reload
          expect(user.score).to eq(7)
          expect(user.streak).to eq(2)
          expect(session[:streak_count]).to eq(0)
        end
      end
    end

    context 'user with streak 3, score 8, session streak 3' do
      let!(:user) {FactoryBot.create(:user, email: 'testuser@example.com', score: 8, streak: 3)}
      before(:each) do
        session[:streak_count] = 3
        sign_in user
      end
      context 'incorrect answer' do
        let!(:trivia_question) {FactoryBot.build(:trivia_question, :with_correct_answer).save(validate: false)}
        let(:answer) {FactoryBot.create(:answer, correct: false, answer_text: 'Sloth', trivia_question: TriviaQuestion.first)}

        before do
          post :check, {params:
                            {
                                answer_id: answer.id,
                                trivia_question_id: answer.trivia_question.id
                            }
          }
        end

        it 'redirects to show page, decreases user score (default 0) & session streak_count' do
          expect(response.content_type).to eq("text/html")
          expect(response.status).to eq(302)
          expect(response).to redirect_to(trivia_question_answer_path(answer.trivia_question.id, answer))

          user.reload
          expect(user.score).to eq(7)
          expect(user.streak).to eq(3)
          expect(session[:streak_count]).to eq(0)
        end
      end
    end
  end

  context '#destroy' do
    context 'user with streak 1, score 8, session streak 2' do
      let!(:user) {FactoryBot.create(:user, email: 'testuser@example.com', score: 8, streak: 1)}
      before(:each) do
        session[:streak_count] = 2
        sign_in user
      end
      context 'destroy rounds' do
        let!(:trivia_question) {FactoryBot.build(:trivia_question, :with_correct_answer).save(validate: false)}
        let(:answer) {FactoryBot.create(:answer, correct: false, answer_text: 'Sloth', trivia_question: TriviaQuestion.first)}

        before do
          delete :destroy, {params:
                            {
                                trivia_question_id: answer.trivia_question.id
                            }
          }
        end

        it 'redirects to root page, decreases user score (default 0) & session streak_count' do
          expect(response.content_type).to eq("text/html")
          expect(response.status).to eq(302)
          expect(response).to redirect_to(root_path)

          user.reload
          expect(user.score).to eq(8)
          expect(user.streak).to eq(2)
          expect(session[:streak_count]).to be(nil)
        end
      end
    end
  end
end