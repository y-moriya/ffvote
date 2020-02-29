module.exports = {
  themeConfig: {
    sidebar: [
      '/',
      {
        title: 'カテゴリ別ランキング',
        path: '/cat/',
        children: [
          '/chara',
          '/monster',
          '/music',
        ]
      },
      {
        title: 'シリーズ別ランキング',
        children: [
          '/ff1',
          '/ff2',
          '/ff3',
          '/ff4',
          '/ff5',
          '/ff6',
          '/ff7',
          '/ff8',
          '/ff9',
          '/ff10',
          '/ff11',
          '/ff12',
          '/ff13',
          '/ff14',
          '/ff15',
          '/ff99'
        ]
      }
    ]
  }
}