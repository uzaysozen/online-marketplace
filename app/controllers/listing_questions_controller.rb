class ListingQuestionsController < ApplicationController
    before_action :set_listing_question, only: [:show, :edit, :update, :destroy]
  
    # GET /listing_questions
    def index
      @listing_questions = ListingQuestion.all
    end
  
    # GET /listing_questions/1
    def show
    end
  
    # GET /listing_questions/new
    def new
      @listing_question = ListingQuestion.new
    end
  
    # GET /listing_questions/1/edit
    def edit
    end
  
    # POST /listing_questions
    def create
      @listing_question = ListingQuestion.new(listing_question_params)
  
      if @listing_question.save
        redirect_to listing_questions_path, notice: 'Listing question was successfully created.'
      else
        render :new
      end
    end
  
    # PATCH/PUT /listing_questions/1
    def update
      if @listing_question.update(listing_question_params)
        redirect_to listing_questions_path, notice: 'Listing question was successfully updated.'
      else
        render :edit
      end
    end
  
    # DELETE /listing_questions/1
    def destroy
      @listing_question.destroy
      redirect_to listing_questions_url, notice: 'Listing question was successfully deleted.'
    end
  
    # POST /listing_questions/search
    def search
      @listing_questions = ListingQuestion.where(listing_id: params[:search][:listing_id])
      @listing_questions = @listing_questions.where(question: params[:search][:question]) if params[:search][:question].present?
      render :index
    end
  
    private
      # Callback functions to share common setup or constraints between actions.
      def set_listing_question
        @listing_question = ListingQuestion.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def listing_question_params
        params.require(:listing_question).permit(:question, :answer)
      end
  end