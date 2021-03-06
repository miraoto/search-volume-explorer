class FileUtil
  def self.import_ideas(records)
    records.each do |query, targeting_idea|
      file_path = "tmp/#{query}_volume.txt"
      file = File.open(file_path,'a')
      targeting_idea.each do |ti|
        record = []
        record << ti[:data]['KEYWORD_TEXT'][:value]
        search_volumes = ti[:data]["TARGETED_MONTHLY_SEARCHES"][:value]
        search_volumes.each do |sv|
          record << sv[:count]
        end
        file.puts record.join("\t")
      end
      p "#{file_path} wrote."
      file.close
    end
  end

  def self.import_stats(records)
    file_path = "tmp/stats_volume.txt"
    file = File.open(file_path,'a')
    records.each do |data|
      record = []
      record << data[:data]['KEYWORD_TEXT'][:value]
      search_volumes = data[:data]["TARGETED_MONTHLY_SEARCHES"][:value]
      search_volumes.each do |sv|
        record << sv[:count]
      end
      file.puts record.join("\t")
    end
    p "#{file_path} wrote."
    file.close
  end
end
