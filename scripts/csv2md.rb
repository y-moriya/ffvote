require 'csv'

CSV_FILE ='./ranking.csv'
CSV_HEADER = 'category,rank,title,series,series_orig,years,years_orig,votes'
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
    'ファイナルファンタジーIX' => 'ff5',
    'ファイナルファンタジーV' => 'ff6',
    'ファイナルファンタジーVI' => 'ff7',
    'ファイナルファンタジーVII' => 'ff8',
    'ファイナルファンタジーVIII' => 'ff9',
    'ファイナルファンタジーX' => 'ff10',
    'ファイナルファンタジーXI' => 'ff11',
    'ファイナルファンタジーXII' => 'ff12',
    'ファイナルファンタジーXIII' => 'ff13',
    'ファイナルファンタジーXIV' => 'ff14',
    'ファイナルファンタジーXV' => 'ff15'
}

to_series_jp = orig_series_to_s.invert

@csv = CSV.read(CSV_FILE, 'r:utf-8', headers: true)

def getCategoryDataBySeries(category, series)
  results = []
  @csv.each do |line|
    if line['category'] == category
      if line['series'] == series
        results.push(ResultRow.new(line['title'], series, category, line['rank']))
      end
    end
  end

  return results
end

class ResultRow
  attr_accessor :title, :series, :category, :rank

  def initialize(t, s, c, r)
    @title = t
    @series = s
    @category = c
    @rank = r
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
  end

  def get_link_monster
  end

  def get_link_music
  end
end

res = getCategoryDataBySeries('music', 'ff1')
res.each do |r|
  puts r.title
end