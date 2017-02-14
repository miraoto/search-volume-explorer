# search-volume-explorer

Investigate the monthly search volume of the organic search


## Getting started

### 1. Install your library of choice using RubyGems.

```
 $ bundle install --path=vendor/bundle
```

### 2. Copy the 'adwords_api.yml' file for your product to your home directory and fill out the required properties.

[adwords_api.yml](https://github.com/miraoto/search-volume-explorer/blob/master/adwords_api.yml)

### 3. Setup your OAuth2 credentials.

[https://developers.google.com/api-client-library/ruby/guide/aaa_oauth](OAuth 2.0  |  API Client Library for Ruby (Alpha)  |  Google Developers)


## Usage

Investigate the monthly search volume of the organic search to keyword.

    $ rake search_volume_explorer:query_stats[foo, bar]

Investigate related keywords of the monthly search volume.

    $ rake search_volume_explorer:query_idea[foo, bar]

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/miraoto/search-volume-explorer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

