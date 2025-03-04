# README

クロノタイプチェッカー

⚪︎サービス概要 このサービスは、2択から3択の質問に答えることでクロノタイプ（体内時計）を判定し、判定結果に基づいた予定表を作成することができる。 自分のクロノタイプを知ることで自分に合った生活周期を把握でき、最適な睡眠時間や学習・仕事の効果的な時間帯を設定することで生産性を向上させることができる。 そして、これらを予定表として可視化することで日々の生活と結びつけ習慣づけることを促す。

⚪︎サービス開発の背景 ・自分自身が朝型人間ではなく、朝活に挑戦しては失敗し、ネガティブな気持ちになることや仮に早く起きれたとしても頭が働かず、効率が上がらないことに悩んでいた。 そんな中、早く起きるための方法を探していた時に、偶然クロノタイプ診断に出会い、診断をしてみたところ自分が夜型（オオカミ型）だと分かった。 朝早く起きることが自分の体内時計に合っていないと知り、今まで早く起きれられなかったことや早く起きても作業に集中できない原因が分かり心が軽くなった。 クロノタイプを知ってから体内時計に合わせた予定を立てることで、学習効率を向上させることに成功した。 ・前職で朝型の生活リズムに適応できず、そのプレッシャーから不眠に陥り、最終的に不登校になってしまった生徒がいた。当時は知識がなく 「頑張って起きて」としか言えなかった自分の無力さを痛感した。クロノタイプについての理解が広まれば、不登校陥った生徒のように悩む人が減り、 朝型中心の社会がより柔軟になるのではないかと考え、クロノタイプを知るきっかけを作りたいと思い、このサービスを作成することにした。

⚪︎ターゲットユーザー ・中学生～高校生 自身のクロノタイプを理解することで、進路選択の参考にしてもらいたい。 ・20代～40代のリスキリングや学習に取り組むビジネスパーソン 単に早起きして学習時間を確保するのではなく、個人の最適な時間帯を把握し、効率的に学習を進めてもらいたい。

⚪︎サービスの利用イメージ ユーザーにクロノタイプチェッカーを受けてもらう。 判定結果を確認し、自分の特性を知ってもらう。 判定結果に基づいた予定表を作成してもらう。

⚪︎ユーザー獲得について SNSでの宣伝 判定結果をX（旧Twitter）でリンク付きでポストできる機能を実装 ソーシャルポートフォリオへの掲載 RUNTEQコミュニティのtimesなどに掲載

⚪︎サービスの差別化ポイント ・クロノタイプに特化した診断をするという点 ・判定結果から予定表を作成するという機能を実装している点

⚪︎機能候補 MVPリリース時に実装したい機能

・ユーザー登録・ログイン ユーザー名、メールアドレス、パスワード

・クロノタイプ判定機能 以下のパートで提示される2択または3択の問いに答えることで4つのクロノタイプ（イルカ型・ライオン型・クマ型・オオカミ型）の中から 自分に合ったクロノタイプを知ることができる。

パート1の質問 YES/NOで答えられる10個の質問に回答してもらう。ここで「YES」が7つ以上の人は「イルカ型」と判定され、パート2の質問は答えずに 判定結果のページへ移動する。「YES」が6つ以下の人はパート2の質問へ進んでもらい判定を続ける。

例 問1。目覚ましが鳴る前に起きることが多い。 YES or NO

パート2の質問 パート1の質問でイルカ型と判定されていない人はパート2の質問に答えることで自身のクロノタイプを判定する。3択の中から1つ自分に 合った回答を選んでもらい各回答に割り振られた点数を足していく。それを20問分回答してもらい、点数によってクロノタイプを振り分ける。 合計点数が19点〜32点の人はライオン型、33点〜47点の人はクマ型、48点以上の人はオオカミ型と判定され、判定結果に合わせたページへと移行する。

例 問1。決まった時間に起きなければならない時、目覚まし時計やスマホの目覚まし機能を使うか？使う場合はどのように使うか？ a.目覚まし時計は使わなくても起きることができるので使わない。(1) b.目覚まし時計や目覚まし機能は使うが、スヌーズ機能などを使わずに1回で起きることができる。(2) c.目覚ましは1つだけではなくいくつも準備をして起きられるようにする。スヌーズもいくつもセットする。(3)

・クロノタイプ判定結果提示機能 パート1・2の結果を元に判定結果を表示する。 そこには自分が何型なのか・何時に起きて何時に寝るようにすべきか・最も集中できる時間帯はいつか・理想のスケジュールの例を提示する。

クロノタイプに基づいたスケジュールを作成するための条件として会員登録を必須とし、登録をしていない人は登録ページへと誘導する。

判定結果をXでポストできるアラートを出す。

・タイムスケジュール表作成機能 FullCalendarを導入し、自身の診断結果を元に1時間区切りで予定を作成できる表の雛形を提示する。 時間の範囲を指定して予定を埋め込めるようにして自分だけの予定表を作成できるようにする。

〜本リリース時に実装したい追加機能〜

・ユーザー登録・ログイン ユーザー名、メールアドレス、パスワード

・判定結果提示機能 Xでポストをしたら詳しい判定結果が見れるようにする。 ポストした人には詳しい判定結果を見ることができるページに移行させる。

・スケジュール表作成機能 設定した予定を繰り返し使用するか、曜日指定で使用するかなどを選択できるようにする。 自身が作った予定に詳細機能を搭載し、その時間でやりたいことを箇条書きでメモできるようにする。

⚪︎機能の実装方針予定

・ログイン機能 ・ユーザー登録機能 ・診断機能 ・Xへの投稿機能 ・FullCalendar

⚪︎画面遷移図 https://www.figma.com/design/HAm88570dYq9KUBaLHGet8/%E3%82%AF%E3%83%AD%E3%83%8E%E3%82%BF%E3%82%A4%E3%83%97%E3%80%80%E7%94%BB%E9%9D%A2%E6%8E%A8%E7%A7%BB%E5%9B%B3%E6%A1%88?node-id=0-1&p=f&t=0lGbawQIpqlPO72c-0

⚪︎ER図 （ER図のスクリーンショットの画像） Image from Gyazo MVPで実装する予定の機能 -[x]ユーザー登録機能（ユーザー名、メールアドレス、パスワード） (users)

-[x]ログイン機能 (users)

-[x]クロノタイプ判定機能 (questions)

-[x]選択結果と合計の保存(user_answers)

-[x] クロノタイプ判定結果提示機能(user_chronotypes)

-[x]判定されたクロノタイプの表示(user_chronotypes,chronotypes)

-[x]クロノタイプに合わせたスケジュール例の提示 (default_schedules)

-[x]タイムスケジュール表作成機能 (schedules)

-[x]時間範囲指定による予定入力機能 (schedules)

⚪︎本サービスを作成するにあたって参考にした文献 ・マイケル・ブレウス.訳 長谷川 圭.The Power of When Discover Your Chronotype 最良の効果を得るタイミング.パンローリング株式会社 2020年初版 ・マイケル・ブレウス .SLEEP QUIZ.SLEEP DOCTOR https://shop.sleepdoctor.com/pages/at-home-sleep-apnea-test?_gl=1*9kt6ff*_gcl_au*MTUxODM1NDU1MS4xNzM4OTI4NTAz