require 'csv'

CSV_FILE ='./ranking.csv'
CSV_HEADER = 'category,rank,title,series,years,votes'
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

csv_data = CSV.read(CSV_FILE, headers: true)

csv_data.each do |data|

end

def getCategoryDataBySeries(category, series)
    
end