require 'adwords_api'

module GoogleAdwords
  class AdwordsApiClient
    def self.create(service, api_version)
      adwords = AdwordsApi::Api.new
      adwords.service(service, api_version)
    end
  end
end
