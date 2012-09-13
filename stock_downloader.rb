require "net/http" # Needed to download file

#
# A simple stock downloader
# Simply parse a company name from the Dow Jones Industrial
# And The year the company started trading or leave blank default to 7-19-2004
# And it will download a csv file in the current directory from Yahoo
# @copy righted by Stevenson Dorastin 2012
# 

# =============
# stock = StockDownloader.new("AAPl", "08-7-1984")
# url = stock.build_url()
# stock.download_csv(url)
# =============

class StockDownloader
	
	attr_accessor :company, :year
	
	# @param string company the company name
	# @param string year When the company started traded 
	def initialize(company = "GOOG", year = "7-19-2004")
		@company = company
		@year    = year
	end
	
	def build_url(company  = @company, date = @year)
		t = Time.now
		d = date.split("-")
		URI("http://ichart.finance.yahoo.com/table.csv?s=#{company}&d=#{t.month}&e=#{t.day}&f=#{t.year}&g=d&a=#{d[0]}&b=#{d[1]}&c=#{d[2]}&ignore=.csv")
	end
	
	def download_csv(url, filename = @company)
		data = Net::HTTP.get(url)
		f = File.new("#{filename}.csv", "w+") 
		f.write(data)
		f.close
	end
end
