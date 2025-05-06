require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it 'providerがある場合はuidが必須' do
      user = User.new(provider: 'google_oauth2', uid: nil, email: 'a@a.com', password: 'password')
      expect(user).not_to be_valid
      expect(user.errors[:uid]).not_to be_empty
    end

    it 'provider・uidの組み合わせがユニークである' do
      User.create!(provider: 'google_oauth2', uid: '123', email: 'a@a.com', password: 'password')
      user = User.new(provider: 'google_oauth2', uid: '123', email: 'b@b.com', password: 'password')
      expect(user).not_to be_valid
    end
  end

  # インスタンスメソッドのテストは不要とのことなので削除

  describe 'クラスメソッド' do
    it 'create_unique_stringはユニークな文字列を返す' do
      str1 = User.create_unique_string
      str2 = User.create_unique_string
      expect(str1).not_to eq str2
    end

    it 'from_omniauthは既存ユーザーを返す/新規作成する' do
      auth = OmniAuth::AuthHash.new(provider: 'google_oauth2', uid: '999', info: { name: 'Foo', email: 'foo@example.com' })
      user = User.from_omniauth(auth)
      expect(user).to be_persisted
      expect(user.provider).to eq 'google_oauth2'
      expect(user.uid).to eq '999'
    end
  end
end
