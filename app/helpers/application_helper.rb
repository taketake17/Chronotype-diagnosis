module ApplicationHelper
  def default_meta_tags
    {
      site: "クロノタイプチェッカー",
      title: "あなたのクロノタイプを判定しよう！",
      description: "クロノタイプチェッカーで自分に合った生活リズムを見つけましょう。",
      keywords: "クロノタイプ, 睡眠, 健康, ライフスタイル",
      canonical: request.original_url,
      og: {
        site_name: "クロノタイプチェッカー",
        title: "あなたのクロノタイプは何型？",
        description: "今すぐ判定してみましょう！",
        type: "website",
        url: request.original_url,
        image: image_url("logo.png"), # デフォルト画像
        locale: "ja_JP"
      },
      twitter: {
        card: "summary_large_image", # Twitterカード形式
        site: "@your_twitter_account", # あなたのTwitterアカウント名
        image: image_url("logo.png") # デフォルト画像
      }
    }
  end
end
