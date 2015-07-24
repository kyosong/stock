require 'net/http'
class String
	def green;          "\033[32m#{self}\033[0m" end
	def red;            "\033[31m#{self}\033[0m" end
end
file = File.open("/Users/Kyo/Documents/Stock/stocks.txt", 'r')
symboll = file.read
file.close
url= 'http://hq.sinajs.cn/list='+ symboll
res = Net::HTTP.get_response(URI(url))
stock_infos = res.body.split(';')
stock_infos.each do |stock_info|
	if stock_info.length > 1
		res_value = (stock_info.split("=")[1]).delete("\"").split(%r{,\s*})
		stock_name = res_value[0].encode(Encoding.find("utf-8"),Encoding.find("gbk")) 
		last_price = res_value[2].to_f
		now_price = res_value[3].to_f
		benefit = now_price - last_price
		benefit = ((benefit*100).round/100.0)
		percentage = benefit/last_price
		percentage = ((percentage*10000).round/100.0)
#puts stock_name
#puts "#{percentage}"+"%"
if percentage > 0
	puts "#{stock_name}  ￥#{now_price}  (#{benefit})#{percentage}%".red
else if percentage < 0
	puts "#{stock_name}  ￥#{now_price}  (#{benefit})#{percentage}%".green
else
	puts "#{stock_name}  ￥#{now_price}  #{percentage}%"
end
end
end
end

