require 'nokogiri'
require 'open-uri'

def parse
    #je lance la recherche de la page
    page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
end

def scrape (page)
    #chemin Xpath du nom des cryptos
    all_crypto_name = page.xpath('//*[@id="__next"]/div[2]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div')
    #chemin Xpath du prix des crypto
    all_crypto_price = page.xpath('//*[@id="__next"]/div[2]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/div/a/span')

    # je crée mon hash
    crypto_data = {}

    #j'emboite les prix avec les noms dans mon hash
    all_crypto_name.each_with_index do |name, index|
        price = all_crypto_price[index]
        crypto_data[name.text] = price.text
    end

    return crypto_data
end

def output(crypto_data)
    #je transforme mon hash en une array de plusieurs petit hash
    crypto_index = []

    crypto_data.each do |k, v|
        puts "#{k} => #{v.delete_prefix("$").delete(",").to_f}"
    end
end

def perform
    page = parse
    crypto_data = scrape (page)
    output(crypto_data)
end

perform

#une array de hash pas hash de array
#{ "BTC" => 5245.12 } un hash ?