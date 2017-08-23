class ReservationMailer < ApplicationMailer
default from: 'aynacom.webdev@gmail.com'
	def booking_email(customer_id, host_id, reservation_id)
		# byebug
		 @customer=User.find(customer_id)
		 @host=User.find(host_id)
		 @property=Reservation.find(reservation_id).listing
		 @url  = 'http://localhost:3000/sign_in'
		 mail(to: @host.email, subject: 'A New Booking')
	end

end
