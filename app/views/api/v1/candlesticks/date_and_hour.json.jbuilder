
candlesticks_array = []


first_hour = @candlesticks_hour.first.date
date_count = @candlesticks.length

# binding.pry

@candlesticks.each_with_index do |c, index|
  date_integer = (first_hour.to_datetime - date_count.hours + index.hours).to_i
  candlesticks_array << [date_integer*1000, c.open, c.high, c.low, c.close, c.volumn]
end 
@candlesticks_hour.each do |c|
  date_integer = c.timestamp.to_i
  candlesticks_array << [date_integer, c.open, c.high, c.low, c.close, c.volumn]
end


json.ohlcv candlesticks_array.sort_by{|c| c[0]}
