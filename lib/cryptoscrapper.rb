require 'nokogiri'
require 'open-uri'

def parse
    #je lance la recherche de la page
    page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
end

def scrape (page)
    crypto_index = []
    #chemin Xpath du nom des cryptos
    all_crypto_name = page.xpath('//*[@id="__next"]/div[2]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div')
    #chemin Xpath du prix des crypto
    all_crypto_price = page.xpath('//*[@id="__next"]/div[2]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/div/a/span')

    #j'emboite les prix avec les noms dans un hash
    all_crypto_name.each_with_index do |name,index|
        price = all_crypto_price[index]
        crypto_data = {
            name.text => price.text.delete_prefix("$").delete(",").to_f
        }
        #puis j'envoie les hash dans mon array
        crypto_index << crypto_data 
    end
    return crypto_index
end

def perform
    page = parse
    crypto_index = scrape (page)
    puts crypto_index
end

perform
