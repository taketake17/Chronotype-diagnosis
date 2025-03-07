class QuestionSecondController < ApplicationController
    def index
        @questions = Question.where(part: 2)
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

        if @total_score >= 48
            chronotype_name = "オオカミ型"
            redirect_to wolf_path
        elsif @total_score >= 34
            chronotype_name = "クマ型"
            redirect_to bear_path
        elsif @total_score >= 20
            chronotype_name = "ライオン型"
            redirect_to lion_path
        else
          redirect_to question_second_path and return
        end
        chronotype = Chronotype.find_by(name: chronotype_name)
         UserChronotype.create(
         user_id: current_user.id,
         chronotype_id: chronotype.id,
         score: @total_score
         )
    end






    private

    def user_answer_params
      params.require(:user_answer).permit(:question_id, :selected_option)
    end
end
