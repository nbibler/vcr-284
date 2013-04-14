require 'spec_helper'

describe FlickrJsonp do
  describe '#callback_method' do
    it 'returns the callback requested', vcr: { tag: :flickr } do
      FlickrJsonp.new.callback_method('testmethod').
        should == 'testmethod'
    end

    it 'returns a random callback method', vcr: { tag: :flickr, match_requests_on: [:method, VCR.request_matchers.uri_without_params(:jsoncallback)] } do
      random_method = "test#{SecureRandom.hex}"
      FlickrJsonp.new.callback_method(random_method).
        should == random_method
    end
  end
end
