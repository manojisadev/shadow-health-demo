class TriviaQuestionsController < ApplicationController
  before_action :set_trivia_question, only: [:show, :edit, :update, :destroy]

  # GET /trivia_questions
  # GET /trivia_questions.json
  def index
    @trivia_questions = TriviaQuestion.all
  end

  # GET /trivia_questions/1
  # GET /trivia_questions/1.json
  def show
    @answers = @trivia_question.answers
  end

  # GET /trivia_questions/new
  def new
    @trivia_question = TriviaQuestion.new
    4.times do
      @trivia_question.answers.build
    end
  end

  # GET /trivia_questions/1/edit
  def edit
  end

  # POST /trivia_questions
  # POST /trivia_questions.json
  def create
    @trivia_question = TriviaQuestion.new(trivia_question_params)

    respond_to do |format|
      if @trivia_question.save
        format.html {redirect_to @trivia_question, notice: 'Trivia question was successfully created.'}
        format.json {render :show, status: :created, location: @trivia_question}
      else
        format.html {render :new}
        format.json {render json: @trivia_question.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /trivia_questions/1
  # PATCH/PUT /trivia_questions/1.json
  def update
    respond_to do |format|
      if @trivia_question.update(trivia_question_params)
        format.html {redirect_to @trivia_question, notice: 'Trivia question was successfully updated.'}
        format.json {render :show, status: :ok, location: @trivia_question}
      else
        format.html {render :edit}
        format.json {render json: @trivia_question.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /trivia_questions/1
  # DELETE /trivia_questions/1.json
  def destroy
    @trivia_question.destroy
    respond_to do |format|
      format.html {redirect_to trivia_questions_url, notice: 'Trivia question was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  def play
    @trivia_question = TriviaQuestion.order("RANDOM()").first
  end

  def answer
    @user_answer = Answer.find(params[:answer_id])
    # @user_answer.correct
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_trivia_question
    @trivia_question = TriviaQuestion.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def trivia_question_params
    params.require(:trivia_question).permit(:question, answers_attributes: Answer.attribute_names.map(&:to_sym).push(:_destroy))
  end
end
