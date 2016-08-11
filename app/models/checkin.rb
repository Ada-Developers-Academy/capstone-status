require './lib/null_objects/checkin'

class Checkin < ApplicationRecord
  belongs_to :student

  def self.most_recently_entered_date
    most_recently_entered.try(:collected_at) || NullCheckin.new.collected_at 
  end

  private

  def self.most_recently_entered
    @most_recently_entered ||= order('collected_at DESC').first
  end
end
