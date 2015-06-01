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

### Archive

You can archive a particular item by calling `archive` and passing that item's ID:

```ruby
account.items.archive(1)
```

