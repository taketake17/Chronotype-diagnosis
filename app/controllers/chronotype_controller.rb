class ChronotypeController < ApplicationController
    def dolphin
        @message = Chronotype.find(1)
    end

    def wolf
        @message = Chronotype.find(4)
    end

    def bear
        @message = Chronotype.find(3)
    end

    def lion
        @message = Chronotype.find(2)
    end
end
