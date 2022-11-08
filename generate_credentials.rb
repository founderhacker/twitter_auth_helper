require 'oauth'
require 'json'
require 'typhoeus'
require 'oauth/request_proxy/typhoeus_request'

# INSERT HERE TWITTER DEVELOPER PORTAL > PROJECT > APP > KEYS (https://developer.twitter.com/en/portal/dashboard)
consumer_key = '' # Twitter App "API KEY"
consumer_secret = '' # Twitter App "API Key Secret"

if (consumer_key.length.zero? || consumer_secret.length.zero?)
  abort 'Provide a "consumer_key" and "consumer_secret" in this file before running the script.'
end

consumer = OAuth::Consumer.new(consumer_key, consumer_secret,
  site: 'https://api.twitter.com',
  authorize_path: '/oauth/authenticate',
  debug_output: false)

def get_request_token(consumer)
	consumer.get_request_token()
end

def get_user_authorization(request_token)
  puts "Visit this URL to authorize your app: #{request_token.authorize_url()}"
  puts 'Enter PIN: '
	gets.strip
end

def obtain_access_token(consumer, request_token, pin)
	token = request_token.token
	token_secret = request_token.secret
	hash = { oauth_token: token, oauth_token_secret: token_secret }
	request_token  = OAuth::RequestToken.from_hash(consumer, hash)

	request_token.get_access_token({oauth_verifier: pin})
end

# PIN-based OAuth flow - Step 1
request_token = get_request_token(consumer)

# PIN-based OAuth flow - Step 2
pin = get_user_authorization(request_token)

# PIN-based OAuth flow - Step 3
access_token = obtain_access_token(consumer, request_token, pin)

credentials = {
  "consumer_key" => consumer_key,
  "consumer_secret" => consumer_secret,
  "oauth_token" => access_token.params[:oauth_token],
  "oauth_token_secret" => access_token.params[:oauth_token_secret]
}

File.open('credentials.json', 'w') do |f|
  f.write(JSON.pretty_generate(credentials))
end

puts "Credentials saved as 'credentials.json' - run 'ruby test_tweet.rb' to check."
