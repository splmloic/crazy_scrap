require 'nokogiri'
require 'open-uri'
result = Hash.new
page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))

all_crypto_name = page.xpath('//*[@id="__next"]/div[2]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div')
all_crypto_price = page.xpath('//*[@id="__next"]/div[2]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/div/a/span')

puts "#{all_crypto_name.length}"
puts "#{all_crypto_price.length}"


20.times do |i|
    result[(all_crypto_name.text)[i]] = (all_crypto_price.text)[i]
end
puts result