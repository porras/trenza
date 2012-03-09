require 'open-uri'

class Download
  def initialize(url)
    @url = url
  end
  
  def size
    open(@url).read.size
  end
end

require 'trenza'

urls = [
  'http://google.es',
  'http://amazon.es',
  'http://bebanjo.com'
]

puts urls.map { |url| Download.new(url).parallel.size }.reduce(:+)

