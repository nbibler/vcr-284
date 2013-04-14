require 'spec_helper'

describe FlickrJsonp do
  describe '#callback_method' do
    it 'returns the callback requested', vcr: { tag: :flickr } do
      puts "Requesting for 'testmethod' callback value"
      callback = FlickrJsonp.new.callback_method('testmethod')
      puts "Received #{callback.inspect} method."
      callback.should == 'testmethod'
    end

    it 'returns a random callback method', vcr: { tag: :flickr, match_requests_on: [:method, VCR.request_matchers.uri_without_params(:jsoncallback)] } do
      random_method = "test#{SecureRandom.hex}"
      puts "Requesting for #{random_method.inspect} callback value"
      callback = FlickrJsonp.new.callback_method(random_method)
      puts "Received #{callback.inspect} method."
      callback.should == random_method
    end
  end
end
