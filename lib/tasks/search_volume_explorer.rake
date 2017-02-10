require 'lib/adwords/api_client'
require 'lib/services/targeting_idea_service'
require 'lib/file_util'

namespace :search_volume_explorer do
  desc 'Investigate the monthly search volume of the organic search to keyword.'
  task :query, [:queries] do |task, args|
    begin
      MAX_NUMBER_RESULT_COUNT = 100
      queries = [args[:queries], args.extras].flatten

      client = Adwords::ApiClient.create(:TargetingIdeaService, :v201609)
      entries = TargetingIdeaService.find_entries_by_query(client, queries)
      FileUtil.import(entries)
    end
  end
end
