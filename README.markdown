# Lightspeed POS

An _unofficial_ gem for interacting with [Lightspeed's Point of Sale API](http://www.lightspeedpos.com/retail/help/developers/api/basics/). Works with API keys for the time being.

Most definitely not production ready yet, but you can help by submitting pull requests!

## Getting Started

First, configure the gem:

```ruby
Lightspeed.configure do |c|
  c.api_key = "YOUR_API_KEY_GOES_HERE"
```

Next, make a request for your accounts:

```ruby
client = Lightspeed::Client.new
accounts = client.accounts
```

Pick the account you want to use, and then start using it:

```ruby
account = accounts.first
account.items # This will return the first 100 items from the account
```


