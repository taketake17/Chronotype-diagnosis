class ChronotypeController < ApplicationController
  def dolphin
    @message = Chronotype.find(1)
    @meta_tags = {
      og: {
        title: "イルカ型 - クロノタイプチェッカー",
        description: "イルカ型は繊細でクリエイティブなタイプです。あなたも診断してみませんか？",
        type: "website",
        url: request.original_url,
        image: view_context.image_url("iruka.png")
      },
      twitter: {
        card: "summary_large_image",
        site: "@your_twitter_account",
        title: "イルカ型 - クロノタイプチェッカー",
        description: "イルカ型は繊細でクリエイティブなタイプです。あなたも診断してみませんか？",
        image: view_context.image_url("iruka.png")
      }
    }
    render "chronotype/summary/dolphin"
  end

  def wolf
    @message = Chronotype.find(4)
    @meta_tags = {
      og: {
        title: "オオカミ型 - クロノタイプチェッカー",
        description: "オオカミ型は夜型でクリエイティブな生活が得意です。あなたも診断してみませんか？",
        type: "website",
        url: request.original_url,
        image: view_context.image_url("wolf.png")
      },
      twitter: {
        card: "summary_large_image",
        site: "@your_twitter_account",
        title: "オオカミ型 - クロノタイプチェッカー",
        description: "オオカミ型は夜型でクリエイティブな生活が得意です。あなたも診断してみませんか？",
        image: view_context.image_url("wolf.png")
      }
    }
    render "chronotype/summary/wolf"
  end

  def bear
    @message = Chronotype.find(3)
    @meta_tags = {
      og: {
        title: "クマ型 - クロノタイプチェッカー",
        description: "クマ型は安定した生活リズムが特徴です。あなたも診断してみませんか？",
        type: "website",
        url: request.original_url,
        image: view_context.image_url("kuma.png")
      },
      twitter: {
        card: "summary_large_image",
        site: "@your_twitter_account",
        title: "クマ型 - クロノタイプチェッカー",
        description: "クマ型は安定した生活リズムが特徴です。あなたも診断してみませんか？",
        image: view_context.image_url("kuma.png")
      }
    }
    render "chronotype/summary/bear"
  end

  def lion
    @message = Chronotype.find(2)
    @meta_tags = {
      og: {
        title: "ライオン型 - クロノタイプチェッカー",
        description: "ライオン型は朝活が得意なタイプです。あなたも診断してみませんか？",
        type: "website",
        url: request.original_url,
        image: view_context.image_url("lion.png")
      },
      twitter: {
        card: "summary_large_image",
        site: "@your_twitter_account",
        title: "ライオン型 - クロノタイプチェッカー",
        description: "ライオン型は朝活が得意なタイプです。あなたも診断してみませんか？",
        image: view_context.image_url("lion.png")
      }
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
