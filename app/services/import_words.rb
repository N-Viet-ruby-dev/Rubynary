# frozen_string_literal: true

require "csv"
require "roo"
class ImportWords
  class << self
    def perform(file, project, user)
      data = open_file file
      data.each_with_index(ja: "ja", en: "en", vi: "vi", description: "description") do |row, i|
        next if i.zero?

        word = Word.create! row.merge(created_by_id: user)
        ProjectWord.create! word: word, project_id: project if project.present?
      end
    rescue StandardError => e
      puts e.message
      puts e.backtrace
    end

    private

    def open_file(file)
      case File.extname(file.original_filename)
      when ".csv" then Roo::CSV.new(file.path)
      when ".xls" then Roo::Excel.new(file.path)
      when ".xlsx" then Roo::Excelx.new(file.path)
      else raise "Unknown file type: #{file.original_filename}"
      end
    end
  end
end
