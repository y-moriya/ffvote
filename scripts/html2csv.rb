require 'nokogiri'

RANKING_FILE = './ranking.html'
CSV_FILE ='./ranking.csv'
CSV_HEADER = 'category,rank,title,series,series_orig,years,years_orig,votes'
CATEGORY = ['series', 'chara', 'monster', 'music']
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
orig_series_to_s.default = 'ff99'

def years_to_s(years_orig)
    return years_orig.scan(/\d+/).flatten[0]
end

html = ''
File.open(RANKING_FILE, 'r:utf-8') {|file|
    html = file.read
}

doc = Nokogiri::HTML.parse(html)

File.open(CSV_FILE, 'w+:utf-8') {|file|
    file.puts CSV_HEADER
    CATEGORY.each do |category|
        rank, title, series, years, votes = ""
        doc.xpath("//*[@id=\"#{category}Body\"]/div/div/div/div/ol/li").each do |node|
            node.children.each do |child|
                tmp_rank = child.xpath('em').inner_html
                tmp_title = child.css('.title').inner_html
                tmp_series_html = child.css('p')[1].to_s

                if !tmp_rank.empty?
                    rank = tmp_rank
                elsif !tmp_title.empty?
                    if tmp_title.index('Why <ccffvii mix>')
                        title = 'Why &lt;CCFFVII Mix&gt;'
                    else
                        title = tmp_title
                    end
                end

                if !tmp_series_html.empty?
                    array = tmp_series_html.scan(/fixed">([^<]+)<span class="year">([^<]+)<\/span>/).flatten
                    series = array[0]
                    years = array[1]
                end
            end
            file.puts %Q(#{category},#{rank},#{title},#{orig_series_to_s[series]},#{series},#{years_to_s(years)},#{years},#{votes})
        end
    end
}
