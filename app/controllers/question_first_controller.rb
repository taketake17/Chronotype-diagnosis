class QuestionFirstController < ApplicationController
    def index
        @questions = Question.all
    end
end
