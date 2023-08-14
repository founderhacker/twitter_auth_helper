# Twitter API Auth Helper
this project helps you quickly create OAuth1 credentials, valid with the Twitter v2 API endpoints, without a web application or redirect flow.

## Installing dependencies
do this just one time.

```sh
gem install oauth
gem install json
gem install typhoeus
```

## Quickstart

1. clone the project (`git clone https://github.com/founderhacker/twitter_auth_helper.git`)
2. visit [this page](https://developer.twitter.com/en/portal/dashboard) in your browser, then click the Key icon (will say "Keys and Tokens" on hover), then click "Regenerate" underneath the Consumer Keys section
3. open `generate_credentials.rb` in your text editor and paste the Consumer Key ("API Key") and Consumer Secret ("API Key Secret") from step 2 above
4. `ruby generate_credentials.rb` and follow the prompt to visit a URL and paste in a pin
5. test your credentials via `ruby test_tweet.rb`
6. use the generated credentials (`credentials.json` file) however you wish 
