class TopsController < ApplicationController
    def index
      session.delete(:answers) if session[:answers].present? # answerセッションが存在する場合に削除
      respond_to do |format|
        format.html # これが必要
      end
    end
end
