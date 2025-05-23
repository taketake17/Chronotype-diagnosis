class QuestionFirstController < ApplicationController
  def index
    @questions = Question.where(part: 1).page(params[:page]).per(5)
    @total_questions = Question.where(part: 1).count
    @progress = calculate_progress
  end

  def create
    session[:answers] ||= {}
    current_page = params[:page].to_i
    questions_on_page = Question.where(part: 1).page(current_page).per(5)

    if params[:answers].present? && params[:answers].keys.count == questions_on_page.count
      session[:answers].merge!(filtered_answers)

      if current_page * 5 >= Question.where(part: 1).count
        process_all_answers
      else
        redirect_to question_first_path(page: current_page + 1)
      end
    else
      flash[:alert] = "全ての質問に回答してください。"
      redirect_to question_first_path(page: current_page)
    end
  end

  private

  def calculate_progress
    total_questions = Question.where(part: 1).count # 全質問数
    answered_questions = session[:answers]&.keys&.size || 0 # 回答済みの質問数
    (answered_questions.to_f / total_questions * 100).round # 進捗率計算
  end

  def filtered_answers
    allowed_keys = Question.where(part: 1).pluck(:id).map(&:to_s)
    params.require(:answers).permit(*allowed_keys).to_h
  rescue ActionController::ParameterMissing
    {}
  end

  def process_all_answers
    all_answers = session[:answers]

    if all_answers.blank?
      flash[:alert] = "質問に回答してください。"
      redirect_to question_first_path(page: params[:page]) and return
    end

    total_score = all_answers.values.map(&:to_i).sum

    save_user_or_session_answers(all_answers)
    handle_chronotype_result(total_score)
  end

  def save_user_or_session_answers(answers)
    if user_signed_in?
      answers.each do |question_id, score|
        UserAnswer.create(
          user_id: current_user.id,
          question_id: question_id.to_i,
          selected_option: score.to_i
        )
      end
    else
      session[:saved_answers] = answers # 未ログイン時はセッションに保存しておく
    end
  end

  def handle_chronotype_result(score)
    if score >= 7
      if user_signed_in?
        create_dolphin_chronotype(score)
        session.delete(:answers)
        redirect_to chronotype_summary_dolphin_path # ログイン時のイルカ型結果ページへリダイレクト
      else
        session[:chronotype] = { chronotype_id: 1, score: score }
        redirect_to chronotype_summary_dolphin_path
      end
    else
      session.delete(:answers)
      redirect_to question_second_path # 次の質問ページへ移行（未ログインでも対応）
    end
  end

  def create_dolphin_chronotype(score)
    dolphin_chronotype = Chronotype.find_by(name: "イルカ型")
    UserChronotype.create(
      user_id: current_user.id,
      chronotype_id: dolphin_chronotype.id,
      score: score
    )
  end
end
