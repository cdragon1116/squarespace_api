# Squarespace Api

[![Gem Version](https://badge.fury.io/rb/squarespace_api.svg)](https://rubygems.org/gems/squarespace_api)


Ruby interface to the [Squarespace API](https://developers.squarespace.com/commerce-apis/overview).

## Installation

Available in RubyGems.

```bash
$ gem install 'squarespace_api'
```

Add to your Gem file
```ruby
gem 'squarespace_api'
```



## Quick Example

- Thread Safety Usage

```ruby
require 'squarespace_api'

client = SquarespaceApi::Client.new(
  SquarespaceApi::Config.new(
    access_token: 'your access token'
  )
)

# get one page of order
client.orders.all
=> [<SquarespaceOrderHash>, ...]


# get every page of orders with filter
orders = []
orders = client.orders.all(fulfillmentStatus: 'PENDING') do |orders_per_page|
  orders += orders_per_page
  # or do something
end

# get website
client.website
```


## ResourceGroups

- [Orders](https://developers.squarespace.com/commerce-apis/orders-overview)

```ruby
# get one page
client.orders.all(fulfillmentStatus: 'PENDING')

# get all pages
orders = []
orders = client.orders.all(fulfillmentStatus: 'PENDING') do |orders_per_page|
  orders += orders_per_page
  # or do something
end

# find an order
client.orders.find(id)

# create an order
client.orders.create(params)

# fulfill an order
client.orders.fulfil(id, params)
```

- [Products](https://developers.squarespace.com/commerce-apis/products-overview)

```ruby
client.products.all
client.products.create(params)
client.products.where(id: id)
client.products.find(id)
client.products.find_by_ids([id_1, id_2])
client.products.update(id, params)
client.products.delete(id)
```

- ProductImages

```ruby
# Noted that Path parameters should be passed in params.
client.product_images.upload(file_path, { product_id: product_id })
client.product_images.status(id, { product_id: product_id })
client.product_images.order(id, { product_id: product_id, afterImageId: 'otherImageId' })
client.product_images.update(id, { product_id: product_id, altText: 'my_picture' })
```

- ProductVariants

```ruby
# Noted that Path parameters should be passed in params.
client.product_variants.create({ product_id: product_id })
client.product_variants.update(id, { sku: 'P1234', product_id: product_id })
```


- ProductVarantImages

```ruby
# Noted that Path parameters should be passed in body params.
client.product_variant_images.create({ imageId: image_id, product_id: product_id, variant_id: variant_id })
```

- Inventory

```ruby
client.inventory.all
client.inventory.find(id)
client.inventory_adjustments.create(params)
```

- Profiles

```ruby
client.profiles.all
client.profiles.find(id)
client.profiles.create(params)
```

- StorePages

```ruby
client.store_pages.all
```

- Transactions

```ruby
client.transactions.all
client.transactions.find(id)
client.transactions.find_by_ids([id_1, id_2])
```

- WebhookSubscriptions

```ruby
client.webhook_subscriptions.all
client.webhook_subscriptions.find(id)
client.webhook_subscriptions.create(id)
client.webhook_subscriptions.update(id, params)
client.webhook_subscriptions.delete(id)
client.webhook_subscriptions.send_test_notification(id, params)
client.webhook_subscriptions.rotate_secret(id)
```


## Single Resource

- Website

```ruby
client.website
```

## Oauth App

### Configuration

configure your oauth cerdentials in ENV:

```ruby
# Auto load ENV
SQUARESPACE_CLIENT_ID = 'your client id'
SQUARESPACE_CLIENT_SECRET = 'your client secret'
```

Or configure in your initializer:

```ruby
SquarespaceApi.configure do |c|
  c.client_id = 'your client id'
  c.client_secret = 'your client secret'
end
```

If you have multiple apps, consider thread safe usage:

```ruby
client = SquarespaceApi::Client.new(
  SquarespaceApi::Config.new(
    client_id: 'your client id',
    client_secret: 'your client secret'
  )
)
```

### Oauth Actions

- Construct Oauth Url

```ruby
SquarespaceApi::Client.new.build_oauth_authorize_url(
  redirect_url: 'https://api.test.com/squarespace',
  scope: 'website.orders,website.orders.read',
  state: '1234',
  access_type: "offline"
)

=> 'https://login.squarespace.com/api/1/login/oauth/provider/authorize?client_id=&redirect_url=https://api.test.com/squarespace&scope=website.orders,website.orders.read&state=1234&access_type=offline'
```

- Request Access Token

```ruby
# request access token
client.tokens.create(
  code: 'code sent from Squaerspace',
  redirect_uri: "your redirect uri"
)
```

- Request Refresh Token

```ruby
client.tokens.create(
  refresh_token: 'some_refresh_token',
  grant_type: "refresh_token"
)
```
