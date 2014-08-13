# scrapper.rb
require 'nokogiri'
require 'open-uri'



def filter_links(rows, regex)
  results = []
  rows.each do |row|
    links_text  = row.css(".hdrlnk").text
    if links_text.match(regex) && links_text.match(regex).length
      uri = row.css(".hdrlnk").attribute("href")
      url = "http://sfbay.craigslist.org" + uri 
      results.push url
    end
  end
  return results
  # takes in rows and returns uses
  # regex to only return links 
  # that have "pup", "puppy", or "dog"
  # keywords
end

def get_todays_rows(doc, date_str)
  rows = doc.css(".row")
  date_results = []
  rows.each do |row|
    if row.css(".date").text == date_str 
      date_results.push row
    end
  end
  return date_results

  # puts page.css(".rows a").map do |link|
  #   puts link
  #  1.) open chrome console to look in inside p.row to see
  #  if there is some internal date related content

  #  2.) figure out the class that you'll need to select the
  #   date from a row

end

def get_page_results
  url = "http://sfbay.craigslist.org/sfc/pet/"
  doc = Nokogiri::HTML(open(url))
  return doc
 
 
end

def search(date_str)
  doc = get_page_results
  dt_results = get_todays_rows(doc, date_str)
  regex = /puppies|pup|dog/i
  links = filter_links(dt_results, regex)
  puts links  
  


end

# want to learn more about 
# Time in ruby??
# #   http://www.ruby-doc.org/stdlib-1.9.3/libdoc/date/rdoc/Date.html#strftime-method
today = Time.now.strftime("%b %d")
search(today)