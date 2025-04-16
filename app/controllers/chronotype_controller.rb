class ChronotypeController < ApplicationController
  def dolphin
    @message = Chronotype.find(1)
    set_meta_tags og: {
        title: "イルカ型 - クロノタイプチェッカー",
        description: "私のクロノタイプはイルカ型！繊細でクリエイティブなタイプです。あなたのクロノタイプは何型？",
        type: "website",
        url: root_url,
        image: view_context.image_url("iruka_ogp.png")
      },
      twitter: {
        card: "summary_large_image",
        site: "@your_twitter_account",
        title: "イルカ型 - クロノタイプチェッカー",
        description: "私のクロノタイプはイルカ型！繊細でクリエイティブなタイプです。あなたのクロノタイプは何型？",
        image: view_context.image_url("iruka_ogp.png")
      }
    render "chronotype/summary/dolphin"
  end

  def wolf
    @message = Chronotype.find(4)
    set_meta_tags og: {
        title: "オオカミ型 - クロノタイプチェッカー",
        description: "私のクロノタイプはオオカミ型！夜型でクリエイティブな生活が得意です。あなたのクロノタイプは何型？",
        type: "website",
        url: root_url,
        image: view_context.image_url("wolf_ogp.png")
      },
      twitter: {
        card: "summary_large_image",
        site: "@your_twitter_account",
        title: "オオカミ型 - クロノタイプチェッカー",
        description: "私のクロノタイプはオオカミ型！夜型でクリエイティブな生活が得意です。あなたのクロノタイプは何型？",
        image: view_context.image_url("wolf_ogp.png")
      }
    render "chronotype/summary/wolf"
  end

  def bear
    @message = Chronotype.find(3)
    set_meta_tags og: {
        title: "クマ型 - クロノタイプチェッカー",
        description: "私のクロノタイプはクマ型！安定した生活リズムが特徴です。あなたのクロノタイプは何型？",
        type: "website",
        url: root_url,
        image: view_context.image_url("kuma_ogp.png")
      },
      twitter: {
        card: "summary_large_image",
        site: "@your_twitter_account",
        title: "クマ型 - クロノタイプチェッカー",
        description: "私のクロノタイプはクマ型！安定した生活リズムが特徴です。あなたのクロノタイプは何型？",
        image: view_context.image_url("kuma_ogp.png")
      }
    render "chronotype/summary/bear"
  end

  def lion
    @message = Chronotype.find(2)
    set_meta_tags og: {
        title: "ライオン型 - クロノタイプチェッカー",
        description: "私のクロノタイプはライオン型！朝活が得意なタイプです。あなたのクロノタイプは何型？",
        type: "website",
        url: root_url,
        image: view_context.image_url("lion_ogp.png")
      },
      twitter: {
        card: "summary_large_image",
        site: "@your_twitter_account",
        title: "ライオン型 - クロノタイプチェッカー",
        description: "私のクロノタイプはライオン型！朝活が得意なタイプです。あなたのクロノタイプは何型？",
        image: view_context.image_url("lion_ogp.png")
      }
    render "chronotype/summary/lion"
  end

  def details_bear
    render "chronotype/details/bear"
  end

  def details_lion
    render "chronotype/details/lion"
  end

  def details_wolf
    render "chronotype/details/wolf"
  end

  def details_dolphin
    render "chronotype/details/dolphin"
  end
end
