require 'csv'
require 'uri'

class ResultRow
  attr_accessor :title, :series, :series_orig, :category, :rank, :query, :query_music
  GOOGLE_URL = 'https://www.google.co.jp/search?hl=jp&gl=JP&'
  YOUTUBE_URL = 'https://www.youtube.com/results?'
  YOUTUBE_URL2 = 'https://www.youtube.com/watch?v='
  YOUTUBE_MUSIC_VIDEO_ID = {
    "1" => "cxPvGGmWM3A",
    "2" => "1a8OirsKVbc",
    "3" => "OsKEMiq95R8",
    "4" => "4dpqwKGwCwE",
    "5" => "WyTRg-DJ99M",
    "6" => "pzQE_7mn8ts",
    "7" => "n0H6kTppjP8",
    "8" => "Y8vCIGf8EgQ",
    "9" => "W5UWaYDtZvA",
    "10" => "ZwcvoY4ehOI",
    "11" => "oVqdYUlg68I",
    "12" => "HnbFPYUGyMg",
    "13" => "1ob36mdEV_w",
    "14" => "NdQuypPplKY",
    "15" => "Yvf1mMuLyzE",
    "16" => "XoiaKyMwrS0",
    "17" => "WmBPTpvYyIY",
    "18" => "zj50xP9K698",
    "19" => "SrDiiVn1VCk",
    "20" => "LeScjOTYl7g",
    "21" => "tbktye3f0oo",
    "22" => "vnoGM7hqeYM",
    "23" => "U9dEu29RY44",
    "24" => "6ugtWT_iNqw",
    "25" => "Xkv3HbHBdBI",
    "26" => "xLtPRwhrBDg",
    "27" => "Ov7OSp7vMmI",
    "28" => "UksOPciWSXE",
    "29" => "pDQqwO9AovQ",
    "30" => "3XSGMCDmo64",
    "31" => "6uq5AbZXnaQ",
    "32" => "iejFpMuLxqk",
    "33" => "djz5LAkV1so",
    "34" => "RiTt7TN1Dls",
    "35" => "rRmrzSseKGw",
    "36" => "nyVBrqCyrPE",
    "37" => "S9M_3nNUufU",
    "38" => "MLHR9ltzuWM",
    "39" => "G8eCJCcBelo",
    "40" => "kNaOpYzKM68",
    "41" => "xjrmrYv1q_g",
    "42" => "1nuD2QxNNZw",
    "43" => "80PMmK0XNIE",
    "44" => "zTqMgJJsFFY",
    "45" => "WTyCvbfUeoM",
    "46" => "pgSBw4L2mLA",
    "47" => "33IR1eUUC08",
    "48" => "uJ5vkb1lmpg",
    "49" => "_4lJsmCqvCI",
    "50" => "juVZ0TN_2EA",
    "51" => "xx10iSmVMo0",
    "52" => "p86icWXs0CQ",
    "53" => "ajP0SMURixM",
    "54" => "D_Chc7EsgRE",
    "55" => "hNSKDpEXqnM",
    "56" => "PAmV4MbSkHg",
    "57" => "AuYZUZPqrdA",
    "58" => "wVn4uE278s0",
    "59" => "4DqPVakFkOw",
    "60" => "FJA1bYtg76E",
    "61" => "MBVIUxeeYUw",
    "62" => "EoHsNo-ns0M",
    "63" => "0Ong5k7NAbQ",
    "64" => "3RUtPuO8alo",
    "65" => "hSm6_VZuyok",
    "66" => "U32g2jp273o",
    "67" => "RyGf2Jg_nRA",
    "68" => "TjF_V_feppI",
    "69" => "mJ3zdmDKnJ4",
    "70" => "cocbP8T_IL0",
    "71" => "x1HF7QUs3ok",
    "72" => "xRHVX2A8L5s",
    "73" => "XO2F7Oqr4wk",
    "74" => "sZy4pZekFQU",
    "75" => "_vaAXTS7dAw",
    "76" => "kNe-ZNBHWWM",
    "77" => "svfMQ4nr4Pc",
    "78" => "f0YFlBCA42U",
    "79" => "ATJwVBcpJ0Q",
    "80" => "nDBVYqb3pto",
    "81" => "6PGrJczAO-A",
    "82" => "WvgZS25yaxo",
    "83" => "i7pyHtguK_A",
    "84" => "QqNeaNWbZVw",
    "85" => "FFQRJHh3VNc",
    "86" => "VizkMEv6vfA",
    "87" => "3n_dq_YDCo0",
    "88" => "VqvVUsvTZBY",
    "89" => "gLEZuDkEuDk",
    "90" => "cNxwheumkYE",
    "91" => "7OzxC_egkdE",
    "92" => "QK-kOJs3aso",
    "93" => "dMp-KVrNiMg",
    "94" => "4mLq11SLOxQ",
    "95" => "Hwo0vAOAJp0",
    "96" => "pZXW8haxNoM",
    "97" => "YZB3vI6svJ4",
    "98" => "UehvdgLoTWA",
    "99" => "CePstt0-0PY",
    "100" => "FkKVUswNxX8",
  }

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
    # YOUTUBE_URL + @query_music
    YOUTUBE_URL2 + YOUTUBE_MUSIC_VIDEO_ID[@rank.to_s]
  end
end

class Converter
  attr_accessor :csv, :orig_series_to_s, :to_category_jp, :to_series_jp
  
  CSV_FILE ='./ranking.csv'
  CATEGORY_DIST_PATH = '../docs/cat/'
  SERIES_DIST_PATH = '../docs/ser/'
  CSV_HEADER = 'category,rank,title,series,series_orig,years,years_orig,votes'
  MD_TABLE_HEADER = '||Name|総合順位|'
  MD_TABLE_BAR = '|-|-|-|'
  MD_TABLE_HEADER2 = '||Name|シリーズ名|総合順位|'
  MD_TABLE_BAR2 = '|-|-|-|-|'
  MD_TABLE_HEADER3 = '||Name|シリーズ名|'
  MD_TABLE_BAR3 = '|-|-|-|'
  MD_TABLE_HEADER4 = '||Name|'
  MD_TABLE_BAR4 = '|-|-|'
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

  def initialize
    @csv = CSV.read(CSV_FILE, 'r:utf-8', headers: true)
    
    @orig_series_to_s = {
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
    @to_category_jp = {
      'series' => '作品',
      'chara' => 'キャラクター',
      'monster' => 'ボス＆召喚獣', 
      'music' => '音楽'
    }
    @to_series_jp = @orig_series_to_s.invert

  end

  def get_category_result_by_series(category, series)
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

  def get_series_result_by_categories(category)
    results =[]
    @csv.each do |line|
      if line['category'] == category
        results.push(ResultRow.new(line['title'], line['series'], line['series_orig'], category, line['rank']))
      end
    end

    return results
  end
    
  def to_file_by_series
    SERIES.each do |series|
      File.open(SERIES_DIST_PATH + series + '.md', 'w+:utf-8') {|file|
        
        if series == 'ff99'
          file.puts %Q(# その他\n\n)
        else
          file.puts %Q(# #{@to_series_jp[series]}\n\n)
        end

        CATEGORY.each do |category|
          next if category == 'series'
          file.puts %Q(## #{@to_category_jp[category]})
          res = get_category_result_by_series(category, series)

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
  end

  def to_file_by_categories
    CATEGORY.each do |category|
      File.open(CATEGORY_DIST_PATH + category + '.md', 'w+:utf-8') {|file|
        file.puts %Q(# #{@to_category_jp[category]}\n\n)
        if category == 'series'

          file.puts MD_TABLE_HEADER4
          file.puts MD_TABLE_BAR4
          
          i = 0
          res = get_series_result_by_categories(category)
          
          if res.length == 0
            next
          end
          
          res.each do |r|
            file.puts %Q(|#{r.rank}|#{r.title}|\n)
          end

          file.puts ""
        else
          file.puts MD_TABLE_HEADER3
          file.puts MD_TABLE_BAR3
          
          i = 0
          res = get_series_result_by_categories(category)
          
          if res.length == 0
            next
          end
          
          res.each do |r|
            file.puts %Q(|#{r.rank}|[#{r.title}](#{r.get_link})|#{r.series_orig}|\n)
          end

          file.puts ""
        end
      }
    end
  end

end

cvt = Converter.new
cvt.to_file_by_categories
cvt.to_file_by_series