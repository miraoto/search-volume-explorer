require 'parallel'

class TargetingIdeaService
  def self.find_entries_by_query(client, queries, request_type = 'IDEAS')
    entries = {}
    case request_type
    when 'IDEAS'
      Parallel.each_with_index(queries, in_threads: 1) do |query, index|
        begin
          result = targeting_idea_page(client, [query], request_type)
        rescue => e
          puts "Connection failure"
          sleep(3)
          puts "retry.."
          retry
        end
        entries[query] = result[:entries]
      end
    when 'STATS'
      result = targeting_idea_page(client, queries, request_type)
      entries = result[:entries]
    else
      p 'invalid request_type'
    end
    entries
  end

  private

  def self.targeting_idea_page(client, query, request_type)
    selector = {
      idea_type: 'KEYWORD',
      request_type: request_type,
      requested_attribute_types: ['KEYWORD_TEXT', 'SEARCH_VOLUME', 'TARGETED_MONTHLY_SEARCHES'],
      search_parameters: [
        {
          xsi_type: 'RelatedToQuerySearchParameter',
          queries: query
        },
        # include query filter case
        #{
        #  xsi_type: 'IdeaTextFilterSearchParameter',
        #  included: query
        #},
        {
          xsi_type: 'LocationSearchParameter', locations: [
            {
              id: 2392, # '2392' is JP contry code. see: https://developers.google.com/adwords/api/docs/appendix/geotargeting?hl=ja
              type: 'LOCATION',
              location_name: 'Japan'
            }
          ]
        },
        {
          xsi_type: 'NetworkSearchParameter',
          network_setting: {
            target_google_search: true,
            target_search_network: false,
            target_partner_search_network: false
          }
        }
      ],
      paging: {
        start_index: 0,
        number_results: MAX_NUMBER_RESULT_COUNT
      }
    }
    client.get(selector)
  end
end
