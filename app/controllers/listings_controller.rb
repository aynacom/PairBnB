class ListingsController < ApplicationController

	# before_action :require_login


	def index
		 # byebug
		@listings=current_user.listings
	end

	def new

	end

	def create
		
		@listing=current_user.listings.new(listing_params)
		@listing.save
		
		redirect_to user_listings_path

	end

	def show
		@host=User.find(params[:user_id])
		@listing=Listing.find(params[:id])
	end

	def edit
		# byebug
		@listing=Listing.find(params[:id])

	end

	def update
		 # byebug
		 @listing=Listing.find(params[:id])
		 @listing.update(listing_params)
		 redirect_to user_listings_path

	end

	def destroy

		current_user.listings.find(params[:id]).destroy
		redirect_to user_listings_path
	end

	private
	def listing_params
		params.require(:listing).permit(:address,:price_per_night,:tags,photos: [])
		# for arrays use it as photos: []
	end

	# def require_login
	#     unless signed_in?
	#       flash[:error] = "You must be logged in to access this section"
	#       redirect_to sign_in_path # halts request cycle
	#     end
	# end
end
