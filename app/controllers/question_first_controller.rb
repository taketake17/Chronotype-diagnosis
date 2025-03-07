class QuestionFirstController < ApplicationController
    def index
        @questions = Question.where(part: 1)
    end

    def create
        @total_score = params[:answers].values.map(&:to_i).sum

        params[:answers].each do |question_id, score|
          UserAnswer.create(
            user_id: current_user.id,
            question_id: question_id.to_i,
            selected_option: score.to_i
          )
        end

        if @total_score >= 7
            dolphin_chronotype = Chronotype.find_by(name: "イルカ型")
            UserChronotype.create(
            user_id: current_user.id,
            chronotype_id: dolphin_chronotype.id,
            score: @total_score
            )
            redirect_to dolphin_path
        else
          redirect_to question_second_path
        end
    end






    private

    def user_answer_params
      params.require(:user_answer).permit(:question_id, :selected_option)
    end
end
