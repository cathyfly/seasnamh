class Beach < ApplicationRecord
  has_many :reviews
  ratyrate_rateable 'rating'
end
