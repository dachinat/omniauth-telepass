# Omniauth::Telepass

This gem provides OmniAuth OAuth2 solution for Telegram authentication using [Telepass](https://telepass.io). 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-telepass'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-telepass

## Todo

* Write tests

## Known issues

Currently if there's application already authorized on Telepass website and if you log-out from there,
then pop-up window on your website won't initiate a callback, but will redirect to Telepass user account.

This issue is probably bug on Telepass's side and we're investigating this.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).