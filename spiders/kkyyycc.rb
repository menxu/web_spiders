#https://github.com/vifreefly/kimuraframework
class Kkyyycc < ApplicationSpider
  @name = "kkyyycc"
  @start_urls = ["http://www.kkyyy.cc/frim/15.html"]
  @config = {}

  def parse(response, url:, data: {})
  	urls = []
  	loop do
  		response = browser.current_response
  		response.xpath('//div[@class="fed-part-layout fed-back-whits"]/ul/li/a').map{|e| urls << "http://www.kkyyy.cc#{e[:href]}" }

  		next_page = response.xpath('//div[@class="fed-page-info fed-text-center"]/a').search("[text()*='下页']")[0]
  		current_page = response.xpath('//div[@class="fed-page-info fed-text-center"]/a[@class="fed-btns-info fed-rims-info fed-hide fed-show-sm-inline fed-btns-green"]').children.first.text
  		puts urls
  		if next_page && current_page.to_i < 3
  			request_to :parse, url: absolute_url(next_page[:href], base: url)
  		end
  	else
  		break		
  	end

  	in_parallel(:parse_detail_page, urls.uniq, threads: 10)
  end

  def parse_detail_page(response, url:, data: {})
    item = {}

    item[:title] = response.xpath("//dd[@class='fed-deta-content fed-col-xs7 fed-col-sm8 fed-col-md10']/h1/a").children.first.text.gsub('【美剧】', '').strip

    save_to "kkyyycc.json", item, format: :pretty_json
  end

end


# bundle exec kimurai crawl kkyyycc
# bundle exec kimurai crawl zimuzu_advance
# runner可以并行多个爬虫文件，并可在dashboard中查看状态
# bundle exec kimurai runner --include zimuzu_advance