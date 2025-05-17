Chronotype.create([
    {
        name: "イルカ型",
        description: "イルカ型は人口の10%程度しかいない少数のクロノタイプです。他のクロノタイプと比べて眠りが浅く、短い睡眠時間で活動することができます。"
    },
    {
        name: "ライオン型",
        description: "ライオン型は人口の15~20%程度で朝型に分類されるクロノタイプです。ライオンが夜明け前から活動するのと同じように、ライオン型の人も朝早くから活動することができます。"
    },
    {
        name: "クマ型",
        description: "クマ型は人口の50%程度で多くの人が分類されるクロノタイプです。太陽の動きに合わせた生活リズムを持ち、朝から活動をすることもできます。"
    },
    {
        name: "オオカミ型",
        description: "オオカミ型は人口の15~20%程度で夜型に分類されるクロノタイプです。夜にかけて集中力が増していき、夕方が最も集中して作業をすることができます。"
    }
])
# オオカミ型（chronotype_id: 4）のデフォルトスケジュール
[
  { title: "睡眠", start_time: '00:00', end_time: '07:00' },
  { title: "起床", start_time: '07:00', end_time: '07:30' },
  { title: "朝食", start_time: '08:00', end_time: '08:30' },
  { title: "コーヒー休憩", start_time: '11:00', end_time: '11:30' },
  { title: "昼食", start_time: '13:00', end_time: '13:30' },
  { title: "集中モード", start_time: '16:00', end_time: '18:00' },
  { title: "運動", start_time: '18:00', end_time: '19:00' },
  { title: "夕食", start_time: '20:00', end_time: '20:30' },
  { title: "就寝", start_time: '23:30', end_time: '00:00' }
].each do |schedule|
  DefaultSchedule.create!(
    chronotype_id: 4,
    title: schedule[:title],
    activity_type: "オオカミ型のスケジュール",
    start_time: schedule[:start_time],
    end_time: schedule[:end_time],
    day_of_week: 0
  )
end

# イルカ型（chronotype_id: 1）のデフォルトスケジュール
[
  { title: "睡眠", start_time: '00:00', end_time: '06:00' },
  { title: "起床", start_time: '06:00', end_time: '06:30' },
  { title: "運動", start_time: '06:30', end_time: '07:00' },
  { title: "朝食", start_time: '07:00', end_time: '07:30' },
  { title: "コーヒー休憩", start_time: '09:30', end_time: '10:00' },
  { title: "昼食", start_time: '12:00', end_time: '13:00' },
  { title: "集中モード", start_time: '16:00', end_time: '18:00' },
  { title: "夕食", start_time: '19:00', end_time: '20:00' },
  { title: "就寝・睡眠", start_time: '23:30', end_time: '00:00' }
].each do |schedule|
  DefaultSchedule.create!(
    chronotype_id: 1,
    title: schedule[:title],
    activity_type: "イルカ型のスケジュール",
    start_time: schedule[:start_time],
    end_time: schedule[:end_time],
    day_of_week: 0
  )
end

# ライオン型（chronotype_id: 2）のデフォルトスケジュール
[
  { title: "睡眠", start_time: '00:00', end_time: '05:00' },
  { title: "起床", start_time: '05:00', end_time: '05:30' },
  { title: "朝食", start_time: '05:30', end_time: '06:00' },
  { title: "軽食とコーヒー休憩", start_time: '09:00', end_time: '09:30' },
  { title: "昼食", start_time: '12:00', end_time: '12:30' },
  { title: "集中モード", start_time: '13:00', end_time: '15:00' },
  { title: "運動", start_time: '17:00', end_time: '18:00' },
  { title: "夕食", start_time: '18:00', end_time: '19:00' },
  { title: "就寝", start_time: '22:00', end_time: '22:30' }
].each do |schedule|
  DefaultSchedule.create!(
    chronotype_id: 2,
    title: schedule[:title],
    activity_type: "ライオン型のスケジュール",
    start_time: schedule[:start_time],
    end_time: schedule[:end_time],
    day_of_week: 0
  )
end

# クマ型（chronotype_id: 3）のデフォルトスケジュール
[
  { title: "睡眠", start_time: '00:00', end_time: '07:00' },
  { title: "起床", start_time: '07:00', end_time: '07:30' },
  { title: "朝食", start_time: '07:30', end_time: '08:00' },
  { title: "コーヒー休憩", start_time: '10:00', end_time: '10:30' },
  { title: "昼食", start_time: '12:30', end_time: '13:00' },
  { title: "昼寝", start_time: '14:00', end_time: '14:30' },
  { title: "運動", start_time: '18:00', end_time: '19:00' },
  { title: "夕食", start_time: '19:30', end_time: '20:00' },
  { title: "就寝", start_time: '22:30', end_time: '23:00' }
].each do |schedule|
  DefaultSchedule.create!(
    chronotype_id: 3,
    title: schedule[:title],
    activity_type: "クマ型のスケジュール",
    start_time: schedule[:start_time],
    end_time: schedule[:end_time],
    day_of_week: 0
  )
end

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

Question.create([
  {
      question_text: "Q1.あなたは翌日に何も予定がないので好きだけ寝ることができます。あなたは何時に起きますか？",
      option1: "1. 午前6時30分よりも前に起きる",
      option2: "2. 午前6時30分から8時45分の間に起きる",
      option3: "3. 午前8時46分以降に起きる",
      score1: 3,
      score2: 2,
      score3: 1,
      part: 2
  },
  {
      question_text: "Q2.あなたは決まった時間に起きなければならない時、目覚まし時計やスマートフォンのアラームを使いますか？",
      option1: "1. 必要ない。ちょうどいい時間に自分で起きることができる",
      option2: "2. 目覚ましやアラームを必要とするが、スヌーズ機能は使わない、または使っても１回で起きることができる",
      option3: "3. 目覚ましやアラームをいくつもセットし、スヌーズ機能も何度も使う",
      score1: 3,
      score2: 2,
      score3: 1,
      part: 2
  },
  {
      question_text: "Q3.週末はいつ起きますか？",
      option1: "1. 平日と同じ時間",
      option2: "2. 平日の起床時間から1時間後くらいまでには起きる",
      option3: "3. 平日の起床時間から2時間以上後くらいに起きる",
      score1: 3,
      score2: 2,
      score3: 1,
      part: 2
  },
  {
      question_text: "Q4.海外から帰ってきた時、時差ぼけはありますか？",
      option1: "1. 時差ぼけにいつも悩まされる",
      option2: "2. 1,2日で解消される",
      option3: "3. 時差ぼけに悩まされたことはない",
      score1: 3,
      score2: 2,
      score3: 1,
      part: 2
  },
{
      question_text: "Q5.どの時間帯の食事が好きですか？",
      option1: "1. 朝食",
      option2: "2. 昼食",
      option3: "3. 夕食",
      score1: 3,
      score2: 2,
      score3: 1,
      part: 2
  },
  {
      question_text: "Q6.学生時代に戻りもう一度入試を受けるとしたら、試験開始時間はどの時間帯なら最高に集中できると思いますか？",
      option1: "1. 早朝",
      option2: "2. 昼過ぎ",
      option3: "3. 午後の半ば",
      score1: 3,
      score2: 2,
      score3: 1,
      part: 2
  },
  {
      question_text: "Q7.激しい運動をするならどの時間がいいですか？",
      option1: "1. 午前8時より前",
      option2: "2. 午前8時から午後4時の間",
      option3: "3. 午後4時よりあと",
      score1: 3,
      score2: 2,
      score3: 1,
      part: 2
  },
  {
      question_text: "Q8.どの時間に頭がいちばん冴えていますか？",
      option1: "1. 起きてから1時間から2時間後",
      option2: "2. 起きてから2時間から4時間後",
      option3: "3. 起きてから4時間後から6時間後",
      score1: 3,
      score2: 2,
      score3: 1,
      part: 2
  },
  {
      question_text: "Q9.1日に5時間だけ働くとしたらどの時間帯を選択したいですか？",
      option1: "1. 午前5時から10時まで",
      option2: "2. 午前10時から午後3時まで",
      option3: "3. 午後4時から午後9時まで",
      score1: 3,
      score2: 2,
      score3: 1,
      part: 2
  },
  {
      question_text: "Q10. 物事を考えるとき、あなたはどのタイプに近いですか？",
      option1: "1. 論理的に分析して考えるのが得意",
      option2: "2. 状況に応じて、論理的にも直感的にも考えられる",
      option3: "3. 感覚や直感を大切にして考えるのが得意",
      score1: 3,
      score2: 2,
      score3: 1,
      part: 2
  },
  {
      question_text: "Q11.普段、昼寝はしますか？",
      option1: "1. 全くしない",
      option2: "2. 週末などの時間があるときに時々する",
      option3: "3. 昼寝をしたら夜眠れなくなる",
      score1: 3,
      score2: 2,
      score3: 1,
      part: 2
  },
  {
      question_text: "Q12.重い家具の移動や薪割りなどの体力仕事をするなら、どの時間帯が最も効率的で安全だと思いますか？",
      option1: "1. 朝",
      option2: "2. 昼間",
      option3: "3. 夕方",
      score1: 3,
      score2: 2,
      score3: 1,
      part: 2
  },
  {
      question_text: "Q13.普段の生活で、健康のために心がけていることはどれに近いですか？",
      option1: "1. 健康を意識して、できるだけ良い選択をするよう心がけている",
      option2: "2. 健康に良いとわかっていることを、時々実践している",
      option3: "3. 健康に良いと思っていても、なかなか実行に移せていない",
      score1: 3,
      score2: 2,
      score3: 1,
      part: 2
  },
  {
      question_text: "Q14.決断を迫られたとき、どのくらいのリスクなら「挑戦してみよう」と思いますか？",
      option1: "1. ほとんどリスクがない、安定した選択",
      option2: "2. ある程度のリスクがあるが、チャンスもある選択",
      option3: "3. かなりのリスクがあるが、大きなリターンも期待できる選択",
      score1: 3,
      score2: 2,
      score3: 1,
      part: 2
  },
  {
      question_text: "Q15.自分はどのタイプだと思いますか？",
      option1: "1. 未来のビジョンを描くのが得意で、大きな夢を抱くタイプ",
      option2: "2. 過去の経験を大切にしつつ、希望を持って今を精一杯生きるタイプ",
      option3: "3. 何よりも今この瞬間を大切にして、後先考えずにやりたいことをすぐにやるタイプ",
      score1: 3,
      score2: 2,
      score3: 1,
      part: 2
  },
  {
      question_text: "Q16.学生としての自分をどう評価しますか？",
      option1: "1. 優等生",
      option2: "2. 堅実",
      option3: "3. 怠け者",
      score1: 3,
      score2: 2,
      score3: 1,
      part: 2
  },
  {
      question_text: "Q17.朝起きたばかりのあなたは？",
      option1: "1. スッキリ",
      option2: "2. 少し眠気がある、またはぼうっとするが混乱はしない",
      option3: "3. 目が開かない。起きられたとしても全く頭が回らない",
      score1: 3,
      score2: 2,
      score3: 1,
      part: 2
  },
  {
      question_text: "Q18.起きてから30分以内の空腹度は？",
      option1: "1. とても空腹",
      option2: "2. 空腹、または少しだけ空腹",
      option3: "3. 全く空腹を感じない",
      score1: 3,
      score2: 2,
      score3: 1,
      part: 2
  },
  {
      question_text: "Q19.不眠症で悩まされる頻度は？",
      option1: "1. 滅多に無い。時差ボケの時くらい",
      option2: "2. ストレスが強い時や苦しい経験をしたときなどにときどき",
      option3: "3. 結構な頻度で不眠の波がある",
      score1: 3,
      score2: 2,
      score3: 1,
      part: 2
  },
  {
      question_text: "Q20.自分の人生の満足度は？",
      option1: "1. 高い",
      option2: "2. そこそこ満足",
      option3: "3. 低い",
      score1: 3,
      score2: 2,
      score3: 1,
      part: 2
  }
])
