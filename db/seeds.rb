# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Question.create([
    {
        question_text: "Q1.ささいな音や光で目を覚ましたり、眠れなくなってしまうことがある。",
        option1: "YES",
        option2: "NO",
        score1: 1,
        score2: 0,
        part: 1
    },
    {
        question_text: "Q2.食べ物に対してこだわりや関心は全くない。",
        option1: "YES",
        option2: "NO",
        score1: 1,
        score2: 0,
        part: 1
    },
    {
        question_text: "Q3.目覚ましが鳴る前に起きることが多い。",
        option1: "YES",
        option2: "NO",
        score1: 1,
        score2: 0,
        part: 1
    },
    {
        question_text: "Q4.耳栓やアイマスクをしても、飛行機や新幹線の中で寝ることができない。",
        option1: "YES",
        option2: "NO",
        score1: 1,
        score2: 0,
        part: 1
    },
    {
        question_text: "Q5.疲れるとイライラすることが多い。",
        option1: "YES",
        option2: "NO",
        score1: 1,
        score2: 0,
        part: 1
    },
    {
        question_text: "Q6.細いことが気になり過ぎてしまうことがある。",
        option1: "YES",
        option2: "NO",
        score1: 1,
        score2: 0,
        part: 1
    },
    {
        question_text: "Q7.医師の診断かもしくは自己診断で不眠症の結果が出たことがある。",
        option1: "YES",
        option2: "NO",
        score1: 1,
        score2: 0,
        part: 1
    },
    {
        question_text: "Q8.学校に通っていた頃、成績のことが心配で仕方がなかった。",
        option1: "YES",
        option2: "NO",
        score1: 1,
        score2: 0,
        part: 1
    },
    {
        question_text: "Q9.私は完璧主義である。",
        option1: "YES",
        option2: "NO",
        score1: 1,
        score2: 0,
        part: 1
    },
    {
        question_text: "Q10.過去の出来事や将来のことを考え込み過ぎて眠れなくなることがよくある。",
        option1: "YES",
        option2: "NO",
        score1: 1,
        score2: 0,
        part: 1
    }

])
