require 'httparty'
require "pry"

class SheetsDataBuilder
  GROUP_SIZE = 8

  attr_reader :id
  def initialize(id = ENV['SHEETS_ID'])
    raise ArgumentError('Missing Google Sheets ID') unless id
    @id = id
  end

  def data
    grouped_data.map do |group|
      RowCleaner.new(group).clean
    end
  end

  def data_since(date)
    data.select do |entry|
      entry[:collected_at] >= date
    end
  end

  private

  def url
    "https://spreadsheets.google.com/feeds/cells/#{id}/1/public/values?alt=json"
  end

  def grouped_data(refresh = false)
    @grouped_data   = nil if refresh
    @grouped_data ||= raw_data(refresh).each_slice(GROUP_SIZE - 2)
  end

  def raw_data(refresh = false)
    @raw_data   = nil if refresh
    data = HTTParty.get(url)
    @raw_data ||= data['feed']['entry']

    # the first GROUP_SIZE entries are the title row in the spreadsheet
    @raw_data.pop(@raw_data.length - GROUP_SIZE)
  end
end

class RowCleaner
  attr_reader :blob

  def initialize(blob)
    @blob = blob
  end

  def clean
    binding.pry
    @clean ||= {
      collected_at: Date.strptime(blob[0]['content']['$t'], "%m/%d/%Y"),
      cohort: blob[1]['content']['$t'],
      name: blob[2]['content']['$t'],
      yesterday: blob[3]['content']['$t'],
      today: blob[4]['content']['$t'],
      blockers: blob[5]['content']['$t']
    }
  end
end
