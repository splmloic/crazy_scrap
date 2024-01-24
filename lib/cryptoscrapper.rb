require 'nokogiri'
require 'open-uri'
result = Hash.new
page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))

all_crypto_name = page.xpath('//*[@id="__next"]/div[2]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div')
all_crypto_price = page.xpath('//*[@id="__next"]/div[2]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/div/a/span')

puts "#{all_crypto_name.length}"
puts "#{all_crypto_price.length}"
for 
all_crypto_name.each do |name|
    puts name.text #ou n'importe quelle autre opération de ton choix ;)
    result[0] = name.text
end
all_crypto_price.each do |price|
    puts price.text
    result[0] = price.text
end
puts result

all_crypto_name.length.times do |i|
    result[all_crypto_name[i]] = all_crypto_price[i]
end
puts result