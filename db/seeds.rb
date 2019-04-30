URLS =  [ 'https://google.com', 'https://outlook.com', 'https://facebook.com' ]

URLS.each do |url|
  Short.create!(url: url)
end