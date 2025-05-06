require 'rails_helper'

RSpec.describe UserChronotype, type: :model do
  describe "associations" do
    it "belongs to user" do
      assoc = described_class.reflect_on_association(:user)
      expect(assoc.macro).to eq :belongs_to
    end

    it "belongs to chronotype" do
      assoc = described_class.reflect_on_association(:chronotype)
      expect(assoc.macro).to eq :belongs_to
    end
  end

  describe "validation" do
    let(:user) { User.create!(email: "test@example.com", password: "password", username: "テストユーザー") }
    let(:chronotype) { Chronotype.create!(name: "クマ型") }

    it "is valid with valid attributes" do
      user_chronotype = UserChronotype.new(user: user, chronotype: chronotype, score: 10)
      expect(user_chronotype).to be_valid
    end

    it "is invalid without a user" do
      user_chronotype = UserChronotype.new(user: nil, chronotype: chronotype, score: 10)
      expect(user_chronotype).not_to be_valid
    end

    it "is invalid without a chronotype" do
      user_chronotype = UserChronotype.new(user: user, chronotype: nil, score: 10)
      expect(user_chronotype).not_to be_valid
    end
  end
end
