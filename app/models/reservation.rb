class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :property
  scope :upcoming_reservations,->{where("checkin_date > ?", Date.today).order(:checkin_date)}
  scope :current_reservations,->{where("checkou_date > ?", Date.today).where("checkin_date < ?", Date.today).order(:checkou_date)}
end
