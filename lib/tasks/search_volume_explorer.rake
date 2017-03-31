require 'lib/adwords/api_client'
require 'lib/services/targeting_idea_service'
require 'lib/file_util'

MAX_NUMBER_RESULT_COUNT = 100

namespace :search_volume_explorer do
  desc 'Investigate the monthly search volume of the organic search to keyword.'
  task :query_stats, [:queries] do |task, args|
    begin
      process_search_volume(args, 'STATS')
    end
  end

  desc 'Investigate related keywords of the monthly search volume.'
  task :query_ideas, [:queries] do |task, args|
    process_search_volume(args, 'IDEAS')
  end

  private

  def process_search_volume(args, request_type)
    begin
      queries = [args[:queries], args.extras].flatten
      client = Adwords::ApiClient.create(:TargetingIdeaService, :v201609)
      entries = TargetingIdeaService.find_entries_by_query(client, queries, request_type)
      FileUtil.import_ideas(entries)
    end
  end
end
