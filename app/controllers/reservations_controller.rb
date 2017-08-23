class ReservationsController < ApplicationController
	
	  # before_action :require_login
 

 



	def index
		 # byebug
		 # @reservations=current_user.reservations
		 @reservations=current_user.reservations.order(:check_in_date).page params[:page]

		 # byebug
		 @users = User.order(:name).page params[:page]
	end

	def new
		# byebug
		@listing=Listing.find(params[:listing_id])
		@reservation=Reservation.new
	end
	def create

		@listing=Listing.find(params[:listing_id])
		 @reservation=@listing.reservations.build(reservation_params)
		# @reservation.update(user_id:current_user.id)
		# byebug
		@all_cuurent_reservations=Listing.find(@reservation.listing_id).reservations
		available=1
		# byebug
		@all_cuurent_reservations.each do |reserv|
			if @reservation.check_in_date>=reserv.check_in_date&&@reservation.check_in_date<reserv.check_out
				#unavailable1
				available=0
				# byebug
				break
			elsif @reservation.check_out>reserv.check_in_date&&@reservation.check_out<=reserv.check_out
				#unavailable2
				available=0
				# byebug
				break
			end
				
		end
	# byebug
		if available==1&&@reservation.save
			@reservation.update(payment_status:false)
			# byebug
			redirect_to payment_new_path(reservation_id: @reservation.id, something: 'else')
			flash[:success]="Successful Reservation in #{@listing.name}, located in #{@listing.city} from #{@reservation.check_in_date} to #{@reservation.check_out} ! You have to complete your payment now or the reservation will be cancelled!"
		else
			if available==0
				@reservation.errors.add(:base, "Sorry! The property is reserved at these times! Try another time or another property!")
			end
			render 'new'
			#error
		end


		# byebug
		
	end

	def edit
		# byebug
	end

	def show
	end

private
	def reservation_params
		params.require(:reservation).permit(:check_in_date, :check_out,:user_id)
	end
	# def require_login
	#     unless signed_in?
	#       flash[:error] = "You must be logged in to access this section"
	#       redirect_to sign_in_path # halts request cycle
	#     end
	# end

end
