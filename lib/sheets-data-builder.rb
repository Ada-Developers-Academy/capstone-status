require 'httparty'

class SheetsDataBuilder
  GROUP_SIZE = 5

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

  def data_since(timestamp)
    data.select do |entry|
      Time.strptime(entry[:collected_at], "%m/%d/%Y %H:%M:%S") > timestamp
    end
  end

  private

  def url
    "https://spreadsheets.google.com/feeds/cells/#{id}/1/public/values?alt=json"
  end

  def grouped_data(refresh = false)
    @grouped_data   = nil if refresh
    @grouped_data ||= raw_data(refresh).each_slice(GROUP_SIZE)
  end

  def raw_data(refresh = false)
    @raw_data   = nil if refresh
    @raw_data ||= HTTParty.get(url)['feed']['entry']

    # the first GROUP_SIZE entries are the title row in the spreadsheet
    @raw_data.pop(@raw_data.length - GROUP_SIZE)
  end
end

class RowCleaner
  attr_reader :blob
  KEY_ORDER = [:collected_at, :name, :yesterday, :today, :blockers]
  def initialize(blob)
    @blob = blob
  end

  def clean
    @clean ||= blob.each_with_index.reduce({}) do |accum, (chunk, index)|
      accum[KEY_ORDER[index]] = chunk['content']['$t']
      accum
    end
  end
end
