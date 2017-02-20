class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  # GET /answers/new
  def new
    @survey = Survey.last
    @options = @survey.options
  end

  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)

    if @answer.save
      render :show, status: :created
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.fetch(:answer).permit(:survey_id, choices_attributes: [:chosen_id], user_attributes: [:name, :email])
    end
end
