import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'FF大投票まとめ',
  description: '全ファイナルファンタジー大投票の結果をシリーズ別などに分けて集計したサイトです。',
  lang: 'ja',
  themeConfig: {
    sidebar: [
      {
        text: 'シリーズ別ランキング',
        items: [
          { link: '/ser/ff1', text: 'ファイナルファンタジー'},
          { link: '/ser/ff2', text: 'ファイナルファンタジーII'},
          { link: '/ser/ff3', text: 'ファイナルファンタジーIII'},
          { link: '/ser/ff4', text: 'ファイナルファンタジーIV'},
          { link: '/ser/ff5', text: 'ファイナルファンタジーV'},
          { link: '/ser/ff6', text: 'ファイナルファンタジーVI'},
          { link: '/ser/ff7', text: 'ファイナルファンタジーVII'},
          { link: '/ser/ff8', text: 'ファイナルファンタジーVIII'},
          { link: '/ser/ff9', text: 'ファイナルファンタジーIX'},
          { link: '/ser/ff10', text: 'ファイナルファンタジーX'},
          { link: '/ser/ff11', text: 'ファイナルファンタジーXI'},
          { link: '/ser/ff12', text: 'ファイナルファンタジーXII'},
          { link: '/ser/ff13', text: 'ファイナルファンタジーXIII'},
          { link: '/ser/ff14', text: 'ファイナルファンタジーXIV'},
          { link: '/ser/ff15', text: 'ファイナルファンタジーXV'},
          { link: '/ser/ff99', text: 'その他'}
        ]
      },
      {
        text: 'カテゴリ別ランキング',
        items: [
          { link: '/cat/series', text: '作品'},
          { link: '/cat/chara', text: 'キャラクター'},
          { link: '/cat/monster', text: 'ボス＆召喚獣'},
          { link: '/cat/music', text: '音楽'},
        ]
      }
    ]
  }
})