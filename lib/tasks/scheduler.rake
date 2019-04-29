desc "This task is called by the Heroku scheduler add-on"
task :update_page_title => :environment do
  puts "Updating page title..."
  UrlCrawlerJob.perform_later
  puts "done."
end
