require 'nokogiri'
require 'open-uri'

class UrlCrawlerJob < ApplicationJob
  queue_as :default

  def perform(skip_populated)
    filter = {}
    filter = { page_title: nil } if skip_populated
    

    begin
      Short.where(filter).each do |short|
        doc = Nokogiri::HTML(open(short.url, {ssl_verify_mode: 0}))
        short.update_attribute(:page_title, doc.at_css('title').text)
      end
    rescue Timeout::Error
      puts 'Timeout'
    rescue OpenURI::Error => e
      puts e.message
    end

  end
end
