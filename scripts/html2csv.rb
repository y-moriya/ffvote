require 'nokogiri'

RANKING_FILE = './ranking.html'
CSV_FILE ='./ranking.csv'
CSV_HEADER = 'category,rank,title,series,years,votes'
CATEGORY = ['series', 'chara', 'monster', 'music']

html = ''
File.open(RANKING_FILE, 'r:utf-8') {|file|
    html = file.read
}

doc = Nokogiri::HTML.parse(html)

File.open(CSV_FILE, 'w+:utf-8') {|file|
    file.puts CSV_HEADER
    CATEGORY.each do |category|
        rank, title, series, year, votes = ""
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
                    year = array[1]
                end
            end
            file.puts %Q(#{category},#{rank},#{title},#{series},#{year},#{votes})
        end
    end
}
