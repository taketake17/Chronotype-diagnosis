# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def create
    chronotype_id = params[:chronotype_id].presence || session.dig(:chronotype, "chronotype_id")
    Rails.logger.info "取得したクロノタイプID: #{chronotype_id}"

    super do |user|
      if chronotype_id.present?
        UserChronotype.create(
          user_id: user.id,
          chronotype_id: chronotype_id
        )
        Rails.logger.info "UserChronotype 作成成功 - クロノタイプID: #{chronotype_id}"
        session.delete(:chronotype) # セッションデータを削除
      else
        Rails.logger.warn "クロノタイプIDが見つかりません。"
      end
    end
  end

  protected

  def after_sign_up_path_for(resource)
    if resource.user_chronotypes.exists? # データベースでクロノタイプIDの有無を確認
      calendar_index_path # カレンダー画面へリダイレクト
    else
      question_first_path # 質問パート1画面へリダイレクト
    end
  end
end
