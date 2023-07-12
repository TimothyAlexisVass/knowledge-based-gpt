class QuestionsController < ApplicationController
  def index
  end

  def create
    @answer = "I don't know."

    respond_to do |format|
      format.html { redirect_to questions_path } # Redirect back to the index page

      format.json do
        render json: { answer: @answer }
      end
    end
  end

  private

  def question
    params[:question][:question]
  end
end