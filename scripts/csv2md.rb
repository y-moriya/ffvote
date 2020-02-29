require 'csv'
require 'uri'

CSV_FILE ='./ranking.csv'
CATEGORY_DIST_PATH = '../docs/cat/'
SERIES_DIST_PATH = '../docs/ser/'
CSV_HEADER = 'category,rank,title,series,series_orig,years,years_orig,votes'
MD_TABLE_HEADER = '||Name|総合順位|'
MD_TABLE_BAR = '|-|-|-|'
MD_TABLE_HEADER2 = '||Name|シリーズ名|総合順位|'
MD_TABLE_BAR2 = '|-|-|-|-|'
CATEGORY = ['series', 'chara', 'monster', 'music']
SERIES = [
    'ff1',
    'ff2',
    'ff3',
    'ff4',
    'ff5',
    'ff6',
    'ff7',
    'ff8',
    'ff9',
    'ff10',
    'ff11',
    'ff12',
    'ff13',
    'ff14',
    'ff15',
    'ff99'
  ]
orig_series_to_s = {
  'ファイナルファンタジー' => 'ff1',
  'ファイナルファンタジーII' => 'ff2',
  'ファイナルファンタジーIII' => 'ff3',
  'ファイナルファンタジーIV' => 'ff4',
  'ファイナルファンタジーV' => 'ff5',
  'ファイナルファンタジーVI' => 'ff6',
  'ファイナルファンタジーVII' => 'ff7',
  'ファイナルファンタジーVIII' => 'ff8',
  'ファイナルファンタジーIX' => 'ff9',
  'ファイナルファンタジーX' => 'ff10',
  'ファイナルファンタジーXI' => 'ff11',
  'ファイナルファンタジーXII' => 'ff12',
  'ファイナルファンタジーXIII' => 'ff13',
  'ファイナルファンタジーXIV' => 'ff14',
  'ファイナルファンタジーXV' => 'ff15'
}

to_category_jp = {
  'series' => '作品',
  'chara' => 'キャラクター',
  'monster' => 'ボス・召喚獣', 
  'music' => '曲'
}
to_series_jp = orig_series_to_s.invert

@csv = CSV.read(CSV_FILE, 'r:utf-8', headers: true)

def getCategoryDataBySeries(category, series)
  results = []
  @csv.each do |line|
    if line['category'] == category
      if line['series'] == series
        results.push(ResultRow.new(line['title'], series, line['series_orig'], category, line['rank']))
      end
    end
  end

  return results
end

class ResultRow
  attr_accessor :title, :series, :series_orig, :category, :rank, :query, :query_music
  GOOGLE_URL = 'https://www.google.co.jp/search?hl=jp&gl=JP&'
  YOUTUBE_URL = 'https://www.youtube.com/results?'

  def initialize(t, s, so, c, r)
    @title = t
    @series = s
    @series_orig = so
    @category = c
    @rank = r

    @query = URI.encode_www_form(q: %Q(#{@title} #{@series_orig}))
    @query_music = URI.encode_www_form(search_query: %Q(#{@title} #{@series_orig}))
  end

  def get_link
    case @category
    when 'music'
      get_link_music
    when 'monster'
      get_link_monster
    when 'chara'
      get_link_chara
    end
  end

  def get_link_chara
    GOOGLE_URL + "tbm=isch&" + @query
  end

  def get_link_monster
    GOOGLE_URL + "tbm=isch&" + @query
  end

  def get_link_music
    YOUTUBE_URL + @query_music
  end
end

SERIES.each do |series|
  File.open(SERIES_DIST_PATH + series + '.md', 'w+:utf-8') {|file|
    
    if series == 'ff99'
      file.puts %Q(# その他\n\n)
    else
      file.puts %Q(# #{to_series_jp[series]}\n\n)
    end

    CATEGORY.each do |category|
      next if category == 'series'
      file.puts %Q(## #{to_category_jp[category]})
      res = getCategoryDataBySeries(category, series)

      if res.length == 0
        file.puts %Q(nothing.)
        next
      end

      if series == 'ff99'
        file.puts MD_TABLE_HEADER2
        file.puts MD_TABLE_BAR2
  
        res.each_with_index do |r, i|
          file.puts %Q(|#{i+1}|[#{r.title}](#{r.get_link})|#{r.series_orig}|#{r.rank}位|\n)
        end  
      else
        file.puts MD_TABLE_HEADER
        file.puts MD_TABLE_BAR
  
        res.each_with_index do |r, i|
          file.puts %Q(|#{i+1}|[#{r.title}](#{r.get_link})|#{r.rank}位|\n)
        end  
      end
      file.puts "\n"
    end
  }
end
