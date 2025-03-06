# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

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
