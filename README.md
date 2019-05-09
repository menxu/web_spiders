# README

install

```
npm install chromedriver
npm install -g phantomjs
```

Create
```
kimurai generate project web_spiders
kimurai generate spider kkyyycc
```

Test

```
kimurai console kkyyycc --url http://www.kkyyy.cc/frim/15.html

response.xpath('//div[@class="fed-part-layout fed-back-whits"]/ul/li/a').map{|e| e[:href]}
response.xpath('//div[@class="fed-page-info fed-text-center"]/a').search("[text()*='下页']")[0][:href]

kimurai console kkyyycc --url http://www.kkyyy.cc/movie/38825.html
response.xpath("//dt[@class='fed-deta-images fed-list-info fed-col-xs3']/a").attr('data-original').value

response.xpath("//dd[@class='fed-deta-content fed-col-xs7 fed-col-sm8 fed-col-md10']/h1/a").children.first.text.gsub('【美剧】', '').strip


array = response.xpath("//dd[@class='fed-deta-content fed-col-xs7 fed-col-sm8 fed-col-md10']/ul/li").children.map(&:text)
categories = array[array.index('更新：') + 1].split('/')


browser.visit(downloads_page_link)
browser.current_response.xpath("//ul[@class='down-list']/li")


save_to "kkyyycc.json", item, format: :pretty_json
```

启动页面控制台
```
bundle exec kimurai dashboard

url: `http://localhost:3001/spiders`
```

运行
```
bundle exec kimurai crawl kkyyycc
```


# 部署机爬虫环境安装
kimurai setup pi@192.168.31.9 --ask-auth-pass
# 部署到树莓派上，我用的是sshpass方式验证，直接配置免密也可以
kimurai deploy pi@192.168.31.9 --ask-auth-pass --repo-url git@git.xxxxxx.com:xxx/web_spiders_demo.git



#### nokogiri https://www.cnblogs.com/wf0117/p/9218196.html
