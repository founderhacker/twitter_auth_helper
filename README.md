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

1. clone the project
2. inside `generate_credentials.rb` paste the Consumer Key ("API Key") and Consumer Secret ("API Key Secret") for your [Twitter App](https://developer.twitter.com)
3. `ruby generate_credentials.rb` and follow the prompt to visit a URL and paste in a pin
4. test your credentials via `ruby test_tweet.rb`
5. use the generated credentials (`credentials.json` file) however you wish 
