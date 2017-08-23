class PaymentController < ApplicationController
 def new
  	  @client_token = Braintree::ClientToken.generate
  	  @reservation=Reservation.find(params[:reservation_id])
  	  @num_nights=(@reservation.check_out-@reservation.check_in_date).to_i
  	  @total_amount=@num_nights*@reservation.listing.price_per_night
  	  #You should create a specific window of time to make the payment --> use background loops in the server to check if paid within that period or remove them
  	   @current_time=Time.now
  	   @payment_window=1 # in minutes
  	  # current_time+60*@payment_window>Time.now
# https://www.agileplannerapp.com/blog/building-agile-planner/rails-background-jobs-in-threads
      
      # move the following line after the payment is confirmed!
      # (customer, host, reservation_id)

      # ReservationMailer.booking_email(@reservation.user_id, @reservation.listing.user_id, @reservation.id).deliver_now
      # ReservationJob.perform_later(@reservation)

      # a way to id -- but if sidekiq is the default queuing system, you can just use the second following line
      # ReservationJob.perform__async(@reservation) 
      ReservationJob.perform_later(@reservation)
		Thread.new do
			p threaded_reservation_id=@reservation.id
		  sleep(@payment_window*60)
		  p !Reservation.find(threaded_reservation_id).payment_status
			  if !Reservation.find(threaded_reservation_id).payment_status
			  	Reservation.find(threaded_reservation_id).destroy
			  end
		  
		  ActiveRecord::Base.connection.close
		end



  	  # byebug
	end

  def checkout
  	amount=params[:checkout_form][:amount]
  nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

  result = Braintree::Transaction.sale(
   :amount => amount,
   :payment_method_nonce => nonce_from_the_client,
   :options => {:submit_for_settlement => true}
   )

  if result.success?
  	puts 'success'
  	@reservation=Reservation.find(params[:checkout_form][:reservation_id])
  	@reservation.update(payment_status:true)
  	@reservation.payment=params[:checkout_form][:amount]
  	# byebug

    redirect_to :root, :flash => { :success => "Transaction successful!" }
  else
  	puts 'failed'
    redirect_to :root, :flash => { :error => "Transaction failed. Please try again." }
  end 
end

end
