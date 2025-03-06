class QuestionSecondController < ApplicationController
    def index
        @questions = Question.new
    end
end
