require 'test_helper'

class TriviaQuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trivia_question = trivia_questions(:one)
  end

  test "should get index" do
    get trivia_questions_url
    assert_response :success
  end

  test "should get new" do
    get new_trivia_question_url
    assert_response :success
  end

  test "should create trivia_question" do
    assert_difference('TriviaQuestion.count') do
      post trivia_questions_url, params: { trivia_question: { question: @trivia_question.question } }
    end

    assert_redirected_to trivia_question_url(TriviaQuestion.last)
  end

  test "should show trivia_question" do
    get trivia_question_url(@trivia_question)
    assert_response :success
  end

  test "should get edit" do
    get edit_trivia_question_url(@trivia_question)
    assert_response :success
  end

  test "should update trivia_question" do
    patch trivia_question_url(@trivia_question), params: { trivia_question: { question: @trivia_question.question } }
    assert_redirected_to trivia_question_url(@trivia_question)
  end

  test "should destroy trivia_question" do
    assert_difference('TriviaQuestion.count', -1) do
      delete trivia_question_url(@trivia_question)
    end

    assert_redirected_to trivia_questions_url
  end
end
