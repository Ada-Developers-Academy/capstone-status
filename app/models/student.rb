class Student < ApplicationRecord
  has_many :checkins, -> { order('collected_at desc') }
end
