class ChronotypeController < ApplicationController
    def dolphin
         Rails.logger.info "セッションデータ: #{session[:chronotype_id]}"
        @message = Chronotype.find(1)
        render "chronotype/summary/dolphin"
    end

    def wolf
        @message = Chronotype.find(4)
        render "chronotype/summary/wolf"
    end

    def bear
        @message = Chronotype.find(3)
        render "chronotype/summary/bear"
    end

    def lion
        @message = Chronotype.find(2)
        render "chronotype/summary/lion"
    end

    def details_bear
        render "chronotype/details/bear"
    end

    def details_lion
        render "chronotype/details/lion"
    end

    def details_wolf
        render "chronotype/details/wolf"
    end

    def details_dolphin
         Rails.logger.info "セッションデータ: #{session[:chronotype]}"
        render "chronotype/details/dolphin"
    end
end
