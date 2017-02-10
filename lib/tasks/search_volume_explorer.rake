require 'lib/google_adwords/adwords_api_client'
require 'lib/google_adwords/adwords_helper'

namespace :search_volume_explorer do
  desc 'Investigate the monthly search volume of the organic search'
  task :survey, [:keywords] do |task, args|
    begin
      MAX_NUMBER_RESULT_COUNT = 100
      keywords = [args[:keywords], args.extras].flatten

      client = GoogleAdwords::AdwordsApiClient.create(:TargetingIdeaService, :v201609)
      targeting_ideas = GoogleAdwords::AdwordsHelper.targeting_ideas_by_keywords(client, keywords)

      targeting_ideas.each do |query, targeting_idea|
        file_path = "tmp/#{query}_volume.txt"
        file = File.open(file_path,'a')
        targeting_idea.each do |ti|
          record = []
          record << ti[:data]['KEYWORD_TEXT'][:value]
          targeted_monthly_search_values = ti[:data]["TARGETED_MONTHLY_SEARCHES"][:value]
          targeted_monthly_search_values.each do |tmsv|
            record << tmsv[:count]
          end
          file.puts record.join("\t")
        end
        p "#{file_path} wrote."
        file.close
      end
    end
  end
end
