require './lib/sheets-data-builder'

namespace :sheets do
  desc "TODO"
  task update: :environment do
    builder = SheetsDataBuilder.new

    builder.data_since(Checkin.most_recently_entered_date).each do |entry|
      student = Student.find_or_create_by(name: entry[:name])
      student.checkins << Checkin.new(entry.without(:name))
      p "Added checkin number #{student.checkins.length} for #{student.name}."
    end
  end

end
