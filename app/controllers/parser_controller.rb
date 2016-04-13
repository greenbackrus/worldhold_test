require 'open-uri'

class ParserController < ApplicationController

  def get_html(page)
    page_s = "/"
    page_s += "page" + page.to_s unless page == 1
    recieved_document = open('https://habrahabr.ru' + page_s, 'User-Agent' => 'firefox')
    html = Nokogiri::HTML(recieved_document)
  end

  def parse_articles
    articles_array = []
    (1...10).each do |page_number|
      page_html = get_html(page_number)
      articles  = page_html.css(".post_title")
      articles.each do |article|
        articles_array.push({"title" => article.text, "url" => article.first[1]})
      end
    end
    articles_array
  end

  def save_articles(articles_array)
    articles_array.each do |article|
      newbie = Article.new(article)
      newbie.save
    end
  end

  def fill_base
    articles = parse_articles
    save_articles(articles)
    redirect_to root_path  
  end

  def show
    @articles = Article.first(10)
  end

end
