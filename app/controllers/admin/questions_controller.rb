module Admin
  class QuestionsController < Admin::ApplicationController
    before_action :set_question, only: [:show, :edit, :update, :destroy]
    
    def index
      @questions = Question.all
    end

    def show
    end

    def edit
    end

    def draw
      @survey = Survey.where(id: params[:survey_id]).first
      @question = Question.where(id: params[:id]).first
      @survey_results =SurveyResult.where(survey: @survey, q_index: @question.id).group(:q_result).count
    end

    def new
      @question = Question.new
      2.times do |i|
        @question.options.build
      end
    end

    def create
      @question = Question.new(question_params)
      respond_to do |format|
        if @question.save
          format.html { redirect_to admin_question_path(@question), notice: 'Question was successfully created.' }
          format.json { render :show, status: :created, location: @question }
        else
          format.html { render :new }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @question.update(question_params)
          format.html { redirect_to admin_question_path(@question), notice: 'Question was successfully update.' }
          format.json { render :show, status: :ok, location: @question }
        else
          format.html { render :edit }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @question.destroy
      respond_to do |format|
        format.html { redirect_to admin_questions_path }
        format.json { head :no_content }
      end
    end

    private
    def set_question
      @question = Question.where(id: params[:id]).first
    end

    def question_params
      params.require(:question).permit(:q_title, :q_digest, :q_type, options_attributes: [:option_title, :_destroy, :id])
    end
  end
end
