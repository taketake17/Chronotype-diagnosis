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
        session.delete(:chronotype)
      else
        Rails.logger.warn "クロノタイプIDが見つかりません。"
      end
    end
  end
end
