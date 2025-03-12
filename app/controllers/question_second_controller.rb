class QuestionSecondController < ApplicationController
  def index
    @questions = Question.where(part: 2).page(params[:page]).per(5)
    @total_questions = Question.where(part: 2).count
  end

  def create
    session[:answers] ||= {}
    current_page = params[:page].to_i
    questions_on_page = Question.where(part: 2).page(current_page).per(5)

    if params[:answers].present? && params[:answers].keys.count == questions_on_page.count
      session[:answers].merge!(filtered_answers)

      if current_page * 5 >= Question.where(part: 2).count
        process_all_answers
      else
        redirect_to question_second_path(page: current_page + 1)
      end
    else
      flash[:alert] = "全ての質問に回答してください。"
      redirect_to question_second_path(page: current_page)
    end
  end

  private

  def filtered_answers
    allowed_keys = Question.where(part: 2).pluck(:id).map(&:to_s)
    params.require(:answers).permit(*allowed_keys).to_h
  rescue ActionController::ParameterMissing
    {}
  end


  def process_all_answers
    all_answers = session[:answers]

    if all_answers.blank?
      flash[:alert] = "質問に回答してください。"
      redirect_to question_second_path(page: params[:page])
      return
    end

    @total_score = all_answers.values.map(&:to_i).sum

    all_answers.each do |question_id, score|
      UserAnswer.create(
        user_id: current_user.id,
        question_id: question_id.to_i,
        selected_option: score.to_i
      )
    end

    chronotype_name = determine_chronotype(@total_score)

    if chronotype_name.nil?
      redirect_to question_second_path, alert: "スコアが足りません。" and return
    end

    chronotype = Chronotype.find_by(name: chronotype_name)

    if chronotype.nil?
      Rails.logger.error "Chronotype not found for name: #{chronotype_name}"
      redirect_to question_second_path, alert: "クロノタイプが見つかりませんでした。" and return
    end

    UserChronotype.create(
      user_id: current_user.id,
      chronotype_id: chronotype.id,
      score: @total_score
    )

    session.delete(:answers)

    redirect_to_chronotype_path(chronotype_name)
  end

  def determine_chronotype(total_score)
    case total_score
    when 48..Float::INFINITY then "オオカミ型"
    when 34..47 then "クマ型"
    when 20..33 then "ライオン型"
    else nil
    end
  end

  def redirect_to_chronotype_path(chronotype_name)
    case chronotype_name
    when "オオカミ型" then redirect_to chronotype_summary_wolf_path and return
    when "クマ型" then redirect_to chronotype_summary_bear_path and return
    when "ライオン型" then redirect_to chronotype_summary_lion_path and return
    when "イルカ型" then redirect_to chronotype_summary_dolphin_path and return
    else redirect_to question_second_path, alert: "クロノタイプが正しく判定できませんでした。"
    end
  end
end
