class TopsController < ApplicationController
    def index
      session.delete(:answers) if session[:answers].present? # answerセッションが存在する場合に削除
    end
end
