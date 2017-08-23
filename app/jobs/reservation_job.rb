class ReservationJob < ApplicationJob
	
	# include Sidekiq::Worker

	queue_as :default

  	def perform(reservation)
  	
    # Do something later
    ReservationMailer.booking_email(reservation.user_id, reservation.listing.user_id, reservation.id).deliver_now
  	end
  	
end
