require 'oauth'
require 'json'
require 'typhoeus'
require 'oauth/request_proxy/typhoeus_request'

# fetch credentials
if File.exists?('credentials.json')
  credentials = JSON.parse(File.read('credentials.json'))
else
  abort 'First generate credentials by running "ruby generate_credentials.rb"'
end

body = {
  "text": "Testing the Twitter API at #{Time.now.to_i}" # timestamp prevents "duplicate content" API error
}

@consumer = OAuth::Consumer.new(
  credentials['consumer_key'],
  credentials['consumer_secret'],
)
@token = OAuth::Token.new(credentials['oauth_token'], credentials['oauth_token_secret'])
options = {
  method: :post,
  headers: {
    "content-type" => "application/json"
  },
  body: body.to_json
}

oauth_params = {:consumer => @consumer, :token => @token}

hydra = Typhoeus::Hydra.new
url = 'https://api.twitter.com/2/tweets'
req = Typhoeus::Request.new(url, options)
oauth_helper = OAuth::Client::Helper.new(req, oauth_params.merge(:request_uri => url))
req.options[:headers].merge!({"Authorization" => oauth_helper.header})

response = req.run

if response.success?
  puts "Credentials work! Tweet:"
  puts JSON.pretty_generate(JSON.parse(response.body))
else
  puts "Credentials failed, please try generating again."
end
