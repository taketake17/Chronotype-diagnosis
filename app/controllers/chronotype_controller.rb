class ChronotypeController < ApplicationController
    def dolphin
        @message = "あなたはイルカ型です！"
    end

    def wolf
        @message = "あなたはオオカミ型です！"
    end

    def bear
        @message = "あなたはクマ型です！"
    end

    def lion
        @message = "あなたはライオン型です！"
    end
end
