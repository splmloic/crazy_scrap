require 'nokogiri'
require 'open-uri'

def get_depute_url
    site_depute = Nokogiri::HTML(URI.open"https://www2.assemblee-nationale.fr/deputes/liste/alphabetique")

    depute = site_depute.xpath('//*[@id="deputes-list"]/div/ul/li/a/@href')
    depute_url = []

    for depute in depute.each do
        depute_url << depute
    end
end

def get_depute_data (depute_url)
    depute_data = []
begin
    depute_url.length.times do |i|
        dep = Nokogiri::HTML(URI.open"#{"https://www2.assemblee-nationale.fr"+depute_url[i]}")
        depute_mail = dep.xpath('//*[@id="main"]/div/div/div/section[2]/div/ul/li[1]/a/span')
        depute_nom = dep.xpath('//*[@id="main"]/div/div/div/section[1]/div/div[1]/h1')
        depute_prenom = dep.xpath('//*[@id="main"]/div/div/div/section[1]/div/div[1]/h1')

        depute_data_hash = {
            "First Name" => ((depute_prenom.text).match(/(M\.|Mme) (\w+)/))[2],
            "Last Name" => ((depute_nom.text).match(/(M\.|Mme) \w+ (\w+)/))[2], 
            "Mail" => depute_mail.text
        } rescue NoMethodError => e

        puts depute_data_hash    
        depute_data << depute_data_hash
    end
end
    puts depute_data
end
depute_url = get_depute_url
get_depute_data (depute_url)