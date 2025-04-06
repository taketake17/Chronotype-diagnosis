class QuestionSecondController < ApplicationController
  def index
    @questions = Question.where(part: 2).page(params[:page]).per(5)
    @total_questions = Question.where(part: 2).count
    @progress = calculate_progress
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

  def calculate_progress
    total_questions = Question.where(part: 2).count
    answered_questions = session[:answers]&.keys&.size || 0
    (answered_questions.to_f / total_questions * 100).round
  end

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
      redirect_to question_second_path(page: params[:page]) and return
    end

    total_score = all_answers.values.map(&:to_i).sum
    Rails.logger.info "合計スコア: #{total_score}"
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

  def determine_chronotype_id(total_score)
    case total_score
    when 48..Float::INFINITY then Rails.logger.info "オオカミ型判定"; 4 # オオカミ型ID（例：2）
    when 34..47 then Rails.logger.info "クマ型判定"; 3 # クマ型ID（例：3）
    when 20..33 then Rails.logger.info "ライオン型判定"; 2 # ライオン型ID（例：4）
    else Rails.logger.info "該当なし"; nil # 該当なしの場合は nil を返す。
    end
  end

  def handle_chronotype_result(total_score)
    chronotype_id = determine_chronotype_id(total_score)

    if chronotype_id.present?
      if user_signed_in?
        create_chronotype_for_user(chronotype_id, total_score)
        session.delete(:answers) # セッションデータを削除しておく（必要なら）
        redirect_to corresponding_chronotype_path(chronotype_id) # ログイン時の結果ページへリダイレクト
      else
        session[:chronotype] = { chronotype_id: chronotype_id, score: total_score }
        redirect_to corresponding_chronotype_path(chronotype_id) # 未ログイン時もリダイレクト先は同じ。
      end
    else
      redirect_to question_second_path, alert: "クロノタイプが判定できませんでした。"
    end
  end

  def create_chronotype_for_user(chronotype_id, score)
    UserChronotype.create(
      user_id: current_user.id,
      chronotype_id: chronotype_id,
      score: score # スコアも保存する場合はここで設定。
    )
  end

  def corresponding_chronotype_path(chronotype_id)
    case chronotype_id
    when 4 then Rails.logger.info "オオカミ型結果ページへリダイレクト"; chronotype_summary_wolf_path # オオカミ型結果ページへのパス。
    when 3 then Rails.logger.info "クマ型結果ページへリダイレクト"; chronotype_summary_bear_path # クマ型結果ページへのパス。
    when 2 then Rails.logger.info "ライオン型結果ページへリダイレクト"; chronotype_summary_lion_path # ライオン型結果ページへのパス。
    else Rails.logger.warn "質問ページへリダイレクト"; question_second_path # 該当なしの場合は再度質問ページへ。
    end
  end
end
