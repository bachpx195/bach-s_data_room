# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

TAG_DATA = [
 [ 1, "root_tag", nil, nil ],
 [ 2, "Coin categories", "Tags về coin", 1 ],
 [ 3, "News categories", "Tags về tin tức", 1 ],
 [ 4, "Wiki categories", "Tags về wiki", 1 ],
 [ 5, "Site categories", "Tags về website", 1 ],
 [ 6, "Mark tags", "Tags khác", 1 ],
 [ 7, "Currency", "Coin tiền tệ", 2 ],
 [ 8, "Platform", "Coin nền tảng", 2 ],
 [ 9, "Token", "Coin ứng dụng", 2 ],
 [ 10, "Exchange", "Coin sàn", 2 ],
 [ 11, "Shitcoin/Scam", "Coin rác", 2 ],
 [ 12, "Fomo", "Good", 3 ],
 [ 13, "Fud", "Bad", 3 ],
 [ 14, "Event", "Sự kiện", 3 ],
 [ 15, "Predict", "Dự đoán", 3 ],
 [ 16, "Concept", "Khái niệm", 46 ],
 [ 18, "PTKT", "Phân tích kĩ thuật", 46 ],
 [ 19, "Price Action", "Đường giá", 18 ],
 [ 20, "fibbo", "Fibbonance", 18 ],
 [ 21, "EMA", "Đường trung bình", 18 ],
 [ 22, "Formal", "Chính thức", 5 ],
 [ 23, "Blog", "Blog", 5 ],
 [ 24, "General", "Tổng hợp", 5 ],
 [ 25, "New rising", "Mới", 6 ],
 [ 26, "Hot", "Nóng", 6 ],
 [ 27, "Bullish", "Bò", 6 ],
 [ 28, "Bearish", "Gấu", 6 ],
 [ 29, "Important", "Quan trọng", 6 ],
 [ 30, "Saved", "Đã lưu", 6 ],
 [ 31, "Lol", "Hài đcđ", 6 ],
 [ 33, "session_time", "Phiên giao dịch", 34 ],
 [ 34, "timechart", "Khung thời gian", 48 ],
 [ 35, "youtube_chanel", "Kênh youtube", 5 ],
 [ 36, "ptcb", "Phân tích cơ bản", 46 ],
 [ 37, "btc_cycle", "Chu kì của Bitcoin", 18 ],
 [ 38, "PTTL", "Phân tích tâm lý", 46 ],
 [ 39, "contract", "Hợp đồng", 16 ],
 [ 40, "investor", "Người đầu tư", 16 ],
 [ 41, "economics", " Kinh tế học", 50 ],
 [ 42, "guide", "Hướng dẫn cơ bản", 46 ],
 [ 43, "order_market", "Lệnh trade", 42 ],
 [ 44, "the_shark", "Phân tích tâm lý cá mập", 38 ],
 [ 46, "Crypto", "Crypto", 4 ],
 [ 48, "Forex", "Forex", 4 ],
 [ 49, "khai_niem", "Khái niệm", 48 ],
 [ 50, "Ptcb", "Phân Tích Cơ Bản", 48 ],
 [ 51, "price_action", "Price Action chuyên sâu", 48 ],
 [ 52, "Markets&Timeframes", "Thị Trường và Khung thời gian", 51 ],
 [ 53, "base", "Định nghĩa cơ bản", 49 ],
 [ 54, "ForexOrders", "Lệnh Order", 49 ],
 [ 55, "method", "Phương pháp", 48 ],
 [ 56, "parlay", "Chiến thuật kim tự tháp - nhồi lệnh", 55 ],
 [ 57, "news", "Tin Tức", 50 ],
 [ 58, "principle_of_price", "Hiểu về đường giá", 51 ],
 [ 59, "margin", "Margin", 49 ],
 [ 60, "besttimetotrade", "Thời gian tốt nhất để trade", 34 ],
 [ 61, "Symbol categories", "Tag về Symbol Forex", 1 ],
 [ 62, "currency_g10", "G10", 61 ],
 [ 63, "economy_index", "Các chỉ số kinh tế ", 50 ],
 [ 64, "jess_lession", "Bài học từ Jess", 50 ],
 [ 65, "pa_trend", "Xu Hướng", 51 ],
 [ 66, "CFD", "Hợp đồng chênh lệch (CFD)", 61 ],
 [ 67, "Currency pair categories", "Tags về các cặp tiền", 1 ],
 [ 68, "USD", "Cặp tiền chính (Cặp USD)", 67 ],
 [ 69, "EUR", "Cặp EUR", 67 ],
 [ 70, "JPY", "Cặp Yên", 67 ],
 [ 71, "GBP", "Cặp Bảng (Cặp GBP)", 67 ],
 [ 72, "other_pair", "Các căp khác", 67 ],
 [ 73, "contact", "Hợp đồng", 67 ],
 [ 74, "natural_disaster", "Thảm Họa tự nhiên", 50 ],
 [ 75, "candlestick", "Nến", 51 ],
 [ 76, "price_action_candlestick", "Các Mô hình nến chính của Price Action", 51 ],
 [ 77, "Stablecoin", "Coin ổn định", 2 ],
 [ 80, "plan_tag", "Tag về kế hoạch", 1 ],
 [ 81, "plan_year", "Năm", 80 ],
 [ 82, "plan_month", "Tháng", 80 ],
 [ 83, "plan_week", "Tuần", 80 ],
 [ 84, "plan_day", "Ngày", 80 ]
]

MERCHANDISE_DATA = [
 [ 1, 62, "Dollar", "USD", "Mỹ", "<p>Đồng tiền mạnh nhất thế giới</p>\r\n" ],
 [ 2, 62, "Euro", "EUR", "Liên minh châu âu (European Union)", "" ],
 [ 3, 62, "Pound", "GBP", "Anh (United Kingdom)", "" ],
 [ 4, 62, "Yen ", "JPY", "Nhật Bản", "" ],
 [ 5, 62, "Dollar", "AUD", "ÚC (Australia)", "" ],
 [ 6, 62, "Dollar", "NZD", "New Zealand", "" ],
 [ 7, 62, "Dollar", "CAD", "Canada", "" ],
 [ 8, 62, "Franc", "CHF", "Thụy Sỹ (Switzerland)", "" ],
 [ 9, 62, "Krone", "NOK", "Na Uy (Norway)", "" ],
 [ 10, 62, "Krona", "SEK", "Thụy Điển (Sweden)", "" ],
 [ 11, 62, "Krone", "DKK", "Đan Mạch(Denmark)", "" ],
 [ 12, 66, "Vàng", "XAU", "Toàn cầu", "" ],
 [ 13,
  77,
  "Tether",
  "USDT",
  "Hong Kong",
  "<p>USDT is a&nbsp;<a href=\"https://coinmarketcap.com/alexandria/article/what-is-a-stablecoin\">stablecoin</a>&nbsp;(stable-value cryptocurrency) that mirrors the price of the U.S. dollar, issued by a Hong Kong-based company Tether. The token&rsquo;s peg to the USD is achieved via maintaining a sum of dollars in reserves that is equal to the number of USDT in circulation.</p>\r\n\r\n<p>Originally launched in July 2014 as Realcoin, a second-layer cryptocurrency token built on top of Bitcoin&rsquo;s blockchain through the use of the Omni platform, it was later renamed to USTether, and then, finally, to USDT. In addition to Bitcoin&rsquo;s, USDT was later updated to work on the&nbsp;<a href=\"https://coinmarketcap.com/currencies/ethereum/\">Ethereum</a>,&nbsp;<a href=\"https://coinmarketcap.com/currencies/eos/\">EOS</a>,&nbsp;<a href=\"https://coinmarketcap.com/currencies/tron/\">Tron</a>,&nbsp;<a href=\"https://coinmarketcap.com/currencies/algorand/\">Algorand</a>, and&nbsp;<a href=\"https://coinmarketcap.com/currencies/omg/\">OMG</a>&nbsp;blockchains.</p>\r\n\r\n<p>The stated purpose of USDT is to combine the unrestricted nature of cryptocurrencies &mdash; which can be sent between users without a trusted third-party intermediary &mdash; with the stable value of the US dollar.</p>\r\n" ],
 [ 14, 7, "Bitcoin", "BTC", "Toàn cầu", "<p>Đang cập nhật...</p>\r\n" ],
 [ 15, 7, "Litecoin", "LTC", "Toàn cầu", "<p>Đang cập nhật...</p>\r\n" ],
 [ 16, 9, "Basic Attention Token", "BAT", "My", "" ],
 [ 17, 9, "Polkadot", "DOT", "", "" ],
 [ 18, 7, "Riple", "XRP", "Mỹ", "" ],
 [ 19, 9, "ChainLink", "LINK", nil, nil ],
 [ 20, 7, "Dominance", "D", "Toàn cầu", "" ],
 [ 21, 7, "Total", "TOTAL", "Toàn cầu", nil ],
 [ 22, 73, "S&P 500 Index", "SPX", "My", "" ]
]

MERCHANDISE_RATE_DATA =[
 [ 1, 68, "Eurozone / United States", "EUR/USD", 2, 1 ],
 [ 2, 68, "United States / Japan", "USD/JPY", 1, 4 ],
 [ 3, 68, "United Kingdom / United States", "GBP/USD", 1, 1 ],
 [ 4, 68, "United States/ Switzerland", "USD/CHF", 1, 1 ],
 [ 5, 68, "United States / Canada", "USD/CAD", 1, 7 ],
 [ 6, 68, "Australia / United States", "AUD/USD", 1, 1 ],
 [ 7, 1, "New Zealand / United States", "NZD/USD", 6, 1 ],
 [ 8, 69, "Eurozone / Switzerland", "EUR/CHF", 2, 8 ],
 [ 9, 69, "Eurozone / United Kingdom", "EUR/GBP", 2, 3 ],
 [ 10, 1, "Eurozone / Canada", "EUR/CAD", 2, 7 ],
 [ 11, 69, "Eurozone / Canada", "EUR/CAD", 2, 7 ],
 [ 12, 69, "Eurozone / Australia", "EUR/AUD", 2, 5 ],
 [ 13, 69, "Eurozone / New Zealand", "EUR/NZD", 2, 6 ],
 [ 14, 69, "Eurozone / Sweden", "EUR/SEK", 2, 10 ],
 [ 15, 69, "Eurozone / Norway", "EUR/NOK", 2, 9 ],
 [ 17, 70, "euro yen", "EUR/JPY", 1, 1 ],
 [ 18, 70, "United Kingdom / Japan", "GBP/JPY", 1, 4 ],
 [ 19, 70, "Switzerland / Japan", "CHF/JPY", 1, 1 ],
 [ 20, 70, "Canada / Japan", "CAD/JPY", 1, 1 ],
 [ 21, 70, "Australia / Japan", "AUD/JPY", 1, 1 ],
 [ 22, 70, "New Zealand / Japan", "NZD/JPY", 1, 1 ],
 [ 23, 71, "United Kingdom / Switzerland", "GBP/CHF", 3, 8 ],
 [ 24, 71, "United Kingdom / Australia", "GBP/AUD", 3, 5 ],
 [ 25, 71, "United Kingdom / Canada", "GBP/CAD", 3, 7 ],
 [ 26, 71, "United Kingdom / New Zealand", "GBP/NZD", 3, 6 ],
 [ 27, 72, "Australia / Switzerland", "AUD/CHF", 5, 8 ],
 [ 28, 72, "Australia / Canada", "AUD/CAD", 5, 7 ],
 [ 29, 72, "Australia / New Zealand", "AUD/NZD", 5, 6 ],
 [ 30, 72, "Canada / Switzerland\t", "CAD/CHF", 7, 8 ],
 [ 31, 72, "New Zealand / Switzerland", "NZD/CHF", 6, 8 ],
 [ 32, 72, "New Zealand / Canada", "NZD/CAD", 6, 7 ],
 [ 33, 73, "Hợp đồng vàng", "XAU/USD", 12, 1 ],
 [ 34, 8, "BTC/USDT", "BTCUSDT", 14, 13 ],
 [ 35, 8, "LTC/USDT", "LTCUSDT", 15, 13 ],
 [ 36, 8, "BAT/USDT", "BATUSDT", 16, 13 ],
 [ 37, 8, "DOT/USDT", "DOTUSDT", 17, 13 ],
 [ 38, 8, "XRPUSDT", "XRPUSDT", 18, 13 ],
 [ 39, 8, "DOT/BTC", "DOTBTC", 17, 14 ],
 [ 40, 8, "XRPBTC", "XRPBTC", 18, 14 ],
 [ 41, 8, "LTC/BTC", "LTCBTC", 15, 14 ],
 [ 42, 8, "LINK/USDT", "LINKUSDT", 19, 13 ],
 [ 43, 8, "LINK/BTC", "LINKBTC", 19, 14 ],
 [ 44, 8, "BTC/D", "BTCD", 14, 20 ],
 [ 45, 8, "USDT/D", "USDTD", 13, 20 ],
 [ 46, 73, "SPX/D", "SPXUSD", 22, 1 ]
]


if Tag.all.count == 0
  TAG_DATA.each do |data|
    Tag.create(id: data[0], title: data[2], slug: data[1], parent_id: data[3])
  end
end

if Merchandise.all.count == 0
  MERCHANDISE_DATA.each do |data|
    Merchandise.create(id: data[0], tag_id: data[1], name: data[2], slug: data[3], country: data[4], about: data[5])
  end
end


if MerchandiseRate.all.count == 0
  MERCHANDISE_RATE_DATA.each do |data|
    MerchandiseRate.create(id: data[0], tag_id: data[1], name: data[2], slug: data[3], base_id: data[4], quote_id: data[5])
  end
end
