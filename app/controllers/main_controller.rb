class MainController < ApplicationController

require "rest-client"

  AVAILABLE_ORDER = ['country', 'state']
  # VERIFY=['true']

  $des=0
  def index
#-------------FOR APIs trials----
# a=RestClient.get 'https://google.com'
# a.headers
# a.body

# b=RestClient.get "localhost:3000/this_is_the_path"
  	 
# GuestsCleanupJob.perform_later 
# GuestsCleanupJob.set(wait: 10.seconds).perform_later



        @listings=current_user.listings

  end
  def reservations
  	# byebug
  end
  def all
  	
    if !params.include?(:q)
    	  	if AVAILABLE_ORDER.include?(params[:order])&&params[:dec]=='0'
    	  		$des=1
    	  		@listings=Listing.order(params[:order]).page params[:page]
    	  	elsif AVAILABLE_ORDER.include?(params[:order])&&params[:dec]=='1'
    	  		  $des=0
    	  		@listings=Listing.order("#{params[:order]} DESC").page params[:page]
    	  	else
    	  		@listings=Listing.order("country").page params[:page]
    	  		# @listings=Listing.page params[:page]
    	  	end
    else
            # byebug
          if AVAILABLE_ORDER.include?(params[:order])&&params[:dec]=='0'
            $des=1
            @listings=Listing.where("lower(state) LIKE ? OR lower(city) LIKE ? OR lower(country) LIKE ? ","%#{params[:q]}%".downcase,"%#{params[:q]}%".downcase,"%#{params[:q]}%".downcase).order(params[:order]).page params[:page]
          elsif AVAILABLE_ORDER.include?(params[:order])&&params[:dec]=='1'
              $des=0
            @listings=Listing.where("lower(state) LIKE ? OR lower(city) LIKE ? OR lower(country) LIKE ? ","%#{params[:q]}%".downcase,"%#{params[:q]}%".downcase,"%#{params[:q]}%".downcase).order("#{params[:order]} DESC").page params[:page]
          else
            @listings=Listing.where("lower(state) LIKE ? OR lower(city) LIKE ? OR lower(country) LIKE ? ","%#{params[:q]}%".downcase,"%#{params[:q]}%".downcase,"%#{params[:q]}%".downcase).order("country").page params[:page]
            # @listings=Listing.page params[:page]
          end


    end
  	  	if params[:verify]=='true'&&current_user.superadmin?
  	  		listing=Listing.find(params[:id])
  	  		# byebug
  	  		listing.update(verification:1)
  	  		# byebug
  	  		redirect_to main_all_path
  	  	elsif params[:verify]=='true'&& !current_user.superadmin?
  	  		flash[:notice] = "Sorry. You are not allowed to perform this action."
  	  		redirect_to main_all_path


  	  	end

  end
  def country
  	@listings=Listing.order(:country).page params[:page]
  	render template: "main/all"
  end

  def state
  	@listings=Listing.order(:state).page params[:page]
  	render template: "main/all"
  end
end
