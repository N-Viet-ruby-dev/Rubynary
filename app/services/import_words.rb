# frozen_string_literal: true

require "csv"
require "roo"
class ImportWords
  class << self
    MAX_LENGTH = 255

    def perform(file, project, user)
      count_created = 0
      list_rows_error = []
      file_format = File.extname(file.original_filename)
      return [count_created, list_rows_error] unless [".csv", ".xls", ".xlsx"].include?(file_format)

      begin
        data = open_file file
        data.each_with_index(ja: "ja", en: "en", vi: "vi", description: "description") do |row, i|
          next if i.zero?

          if ![row[:ja], row[:vi], row[:en]].all?(&:present?)
            list_rows_error.push(i + 1)
            next
          else
            result = check_length(row[:ja], row[:vi], row[:en], row[:description])
            if result.positive?
              list_rows_error.push(i + 1)
              next
            else
              word = Word.create! row.merge(created_by_id: user)
              ProjectWord.create! word: word, project_id: project if project.present?
              count_created += 1
            end
          end
        end
      rescue StandardError => e
        puts e.message
        puts e.backtrace
      ensure
        return count_created, list_rows_error
      end
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

    def check_length(str_ja, str_en, str_vi, str_description)
      row = if str_description.nil?
              [str_ja, str_en, str_vi]
            else
              [str_ja, str_en, str_vi, str_description]
            end
      elements_length = []
      row.each do |element_row|
        elements_length.push(element_row.length)
      end
      elements_length.count { |element_length| element_length > MAX_LENGTH }
    end
  end
end
