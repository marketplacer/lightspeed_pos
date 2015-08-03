# Lightspeed POS

[![Build Status](https://travis-ci.org/radar/lightspeed_pos.svg?branch=master)](https://travis-ci.org/radar/lightspeed_pos)
[![Code Climate](https://codeclimate.com/github/radar/lightspeed-pos/badges/gpa.svg)](https://codeclimate.com/github/radar/lightspeed-pos)


An _unofficial_ gem for interacting with [Lightspeed's Point of Sale API](http://www.lightspeedpos.com/retail/help/developers/api/basics/). Works with API keys for the time being.

Most definitely not production ready yet, but you can help by submitting pull requests!

## Getting Started

First, intialize a new client:

```ruby
client = Lightspeed::Client.new(api_key: "YOUR_API_KEY_HERE")
```

**OR** you may also choose to pass through an OAuth access token if you have one:

```ruby
client = Lightspeed::Client.new(oauth_token: "YOUR_ACCESS_TOKEN_HERE")
```

Next, make a request for your accounts:

```ruby
accounts = client.accounts
```

Pick the account you want to use, and then start using it:

```ruby
account = accounts.first
account.items # This will return the first 100 items from the account
```

## Account Resources

Account resources share a common API. Account resources that are currently supported by this library are:

* Categories
* Items

To work with account resources, you first need to fetch an account. The examples below are for items, but will also work with other types listed above.

### List

You can fetch a list of items with this:

```ruby
account.items.all
```

### Show

You can fetch a particular item by its ID by doing this:

```ruby
account.items.find(1)
```

### Create

You can create a particular item by calling `create`:

```ruby
account.items.create({
  description: "Onesie"
})
```

### Update

You can update a particular item by calling `update`, passing that item's ID and providing a list of attributes to update:

```ruby
account.items.update(1, {
  description: "Onesie"
})
```

This method isn't available on items themselves because I couldn't work out how to share the account ID easily there.

### Destroy

You can destroy a particular item by calling `destroy` and passing that item's ID:

```ruby
account.items.destroy(1)
```

For the `Items` resource, this is aliased to `archive`:

```ruby
account.items.archive(1)
```

