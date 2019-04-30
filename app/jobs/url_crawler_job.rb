require 'nokogiri'
require 'open-uri'

class UrlCrawlerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Short.all.each do |short|
      doc = Nokogiri::HTML(open(short.url))
      short.update_attribute(:page_title, doc.at_css('title').text)
    end
  end
end
