module.exports = {
  title: 'FF大投票まとめ',
  description: '全ファイナルファンタジー大投票の結果をシリーズ別などに分けて集計したサイトです。',
  locales: {
    '/': {
      lang: 'ja'
    }
  },
  themeConfig: {
    sidebar: [
      '/',
      {
        title: 'シリーズ別ランキング',
        collapsable: false,
        children: [
          ['/ser/ff1', 'ファイナルファンタジー'],
          ['/ser/ff2', 'ファイナルファンタジーII'],
          ['/ser/ff3', 'ファイナルファンタジーIII'],
          ['/ser/ff4', 'ファイナルファンタジーIV'],
          ['/ser/ff5', 'ファイナルファンタジーV'],
          ['/ser/ff6', 'ファイナルファンタジーVI'],
          ['/ser/ff7', 'ファイナルファンタジーVII'],
          ['/ser/ff8', 'ファイナルファンタジーVIII'],
          ['/ser/ff9', 'ファイナルファンタジーIX'],
          ['/ser/ff10', 'ファイナルファンタジーX'],
          ['/ser/ff11', 'ファイナルファンタジーXI'],
          ['/ser/ff12', 'ファイナルファンタジーXII'],
          ['/ser/ff13', 'ファイナルファンタジーXIII'],
          ['/ser/ff14', 'ファイナルファンタジーXIV'],
          ['/ser/ff15', 'ファイナルファンタジーXV'],
          ['/ser/ff99', 'その他']
        ]
      },
      {
        title: 'カテゴリ別ランキング',
        collapsable: false,
        children: [
          ['/cat/chara', 'キャラクター'],
          ['/cat/monster', 'ボス・召喚獣'],
          ['/cat/music', '音楽'],
        ]
      }
    ]
  }
}