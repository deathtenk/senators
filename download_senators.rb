require 'net/http'
 
uri = URI 'http://www.senate.gov/general/contact_information/senators_cfm.xml'
 
def http_request(uri)
  Net::HTTP.start(uri.host, uri.port) do |http|
    p "connecting to #{uri}, #{http}"
    yield(http, uri)
  end
end
 
http_request uri do |http, uri|
  request = Net::HTTP::Post.new(uri)
 
  http.request(request) do |response|
    open('senators.xml', 'w+') do |file|
      response.read_body do |chunk|
        file.write(chunk)
      end
    end
  end
end