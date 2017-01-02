require './lib/sheets-data-builder'

namespace :sheets do
  desc "Fetches, normalizes, and inserts new student checkins from the Google Sheets document"
  task update: :environment do
    builder = SheetsDataBuilder.new

    builder.data_since(Checkin.most_recently_entered_date).each do |entry|
      student = Student.find_or_create_by(name: entry[:name], cohort: entry[:cohort])
      student.checkins << Checkin.find_or_initialize_by(entry.without(:name, :cohort))
      p "Added (or found) checkin number #{student.checkins.length} for #{student.name}."
    end
  end

end
