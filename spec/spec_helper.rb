require 'bundler/setup'
require 'vcr'

$:.unshift(File.expand_path('../../lib', __FILE__))
require 'flickr_jsonp'


VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!

  c.before_record(:flickr) do |interaction|
    callback_value = CGI.parse(interaction.request.uri)['jsoncallback'].first
    interaction.response.body.gsub!(/\b#{Regexp.escape(callback_value)}\b/, "%{DYNAMIC CALLBACK}")
  end

  c.around_http_request do |request|
    if callback_value = CGI.parse(request.uri)['jsoncallback'].first and
      index = VCR.http_interactions.interactions.index { |i| VCR.http_interactions.send(:interaction_matches_request?, request, i) }
      interaction = VCR.http_interactions.interactions[index]
      interaction.response.body.gsub!(/#{Regexp.escape('%{DYNAMIC CALLBACK}')}/, callback_value)
    end
    request.proceed
  end
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end
