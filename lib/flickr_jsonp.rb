require 'securerandom'
require 'faraday'

class FlickrJsonp
  def request(callback = 'random' + SecureRandom.hex)
    connection.get('http://www.flickr.com/services/rest/', {
      api_key: '2454e43003dc9e7b7d08b6703a6d0889',
      format: 'json',
      jsoncallback: callback,
      method: 'flickr.test.echo',
    })
  end

  def callback_method(callback = nil)
    response = request(callback)
    response.success? && response.body =~ /^(\w+)\(/ ? $1 : nil
  end


  private


  def connection
    Faraday.new(url: 'http://www.flickr.com') do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end
end
