class UserAnswer < ApplicationRecord
    belongs_to :user
    belongs_to :question

    validates :selected_option, presence: true
end
