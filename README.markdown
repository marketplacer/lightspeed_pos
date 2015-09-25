# Lightspeed POS

[![Build Status](https://travis-ci.org/radar/lightspeed_pos.svg?branch=master)](https://travis-ci.org/radar/lightspeed_pos)
[![Code Climate](https://codeclimate.com/github/radar/lightspeed-pos/badges/gpa.svg)](https://codeclimate.com/github/radar/lightspeed-pos)


An _unofficial_ gem for interacting with [Lightspeed's Point of Sale API](http://www.lightspeedpos.com/retail/help/developers/api/basics/), ([documentation](http://cloud-docs.lightspeedapp.com/API/APIHelp.help)).

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
accounts = client.accounts.all
```

Pick the account you want to use, and then start using it:

```ruby
account = accounts.first
account.items.first
```

## Resources

resources share a common API. Resources that are currently supported by this library are:

* Accounts
* Categories
* Items
* Item Matrices
* Item Attribute Sets
* Images
* Inventories

To work with account resources, you first need to fetch an account. The examples below are for items, but will also work with other types listed above.

### List

You can fetch a list of items with this:

```ruby
account.items.all
```

You can pass query parameters to this by using the `params` keyword:

```ruby
account.items.all(params: { itemMatrixID: 0 })
```

You can enumerate over a group of 100 resources at a time (the max in a single request) using `each_page`

```ruby
account.items.each_page! do |items|
  # ItemImporter.import(items)
end
```

Or enumerate over each resource using #each (this still only does a request for each 100 items)

```ruby
account.items.each do |item|
  # ItemImporter.import(item)
end
```

### Show

You can fetch a particular item by its ID by doing this:

```ruby
account.items.find(1)
```
If item with id of `1` is not there, this will raise `Lightspeed::Error::NotFound`

You can fetch the first item using `first`
```ruby
account.items.first
```

### Create

You can create a particular item by calling `create`:

```ruby
account.items.create(description: "Onesie")
```

### Update

You can update a particular item by calling `update`, passing that item's ID and providing a list of attributes to update:

```ruby
account.items.update(1, description: "Onesie")
# OR
account.items.find(1)
item.update(description: "Onesie")
```

### Destroy

You can destroy a particular item by calling `destroy` and passing that item's ID:

```ruby
account.images.destroy(1)
# OR
account.images.find(1)
item.destroy
```

For the `Items` resource, `destroy` is aliased to `archive`:
