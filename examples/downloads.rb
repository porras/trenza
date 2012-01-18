require 'open-uri'

class Download
  def initialize(url)
    @url = url
  end
  
  def size
    puts "\nDownloading #{@url}\n"
    s = open(@url).read.size
    puts "\nDone downloading #{@url}\n"
    s
  end
end

require '../lib/trenza'

urls = [
  'http://google.es',
  'http://amazon.es',
  'http://bebanjo.com'
]

sizes = urls.map { |url| Download.new(url).parallel.size }

p sizes
