#DESIGN PATTERN - OBSERVER - LOG TO A .TXT FILE WHEN A NEW REVIEW IS ADDED
require 'Singleton'
class MyLogger
  include Singleton
  def initialize
    @log = File.open("mylog.txt", "a")
  end

  #though test runs neither works in app
  def logInformation(information)
    @log.puts("-----start-----")
    @log.puts(information)
    @log.puts("-----end-----")
    @log.flush
  end
end