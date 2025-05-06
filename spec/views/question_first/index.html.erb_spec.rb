# spec/views/question_first/index.html.erb_spec.rb
require 'rails_helper'

RSpec.describe "question_first/index", type: :view do
  before do
    # ページネーションを使ったダミーオブジェクトをassign
    questions = Kaminari.paginate_array([
      Question.new(id: 1, question_text: "朝ごはんは食べますか？", option1: "YES", option2: "NO"),
      Question.new(id: 2, question_text: "夜更かししますか？", option1: "YES", option2: "NO")
    ]).page(1).per(10)
    assign(:progress, 30)
    assign(:questions, questions)
    allow(questions).to receive(:last_page?).and_return(false)
    render
  end

  it "進捗バーが表示される" do
    expect(rendered).to have_css('#progress-bar[style*="width: 30%"]')
  end

  it "質問文が表示される" do
    expect(rendered).to include("朝ごはんは食べますか？")
    expect(rendered).to include("夜更かししますか？")
  end

  it "選択肢が表示される" do
    expect(rendered).to include("YES")
    expect(rendered).to include("NO")
  end

  it "フォームが表示される" do
    expect(rendered).to have_selector("form")
  end
end
