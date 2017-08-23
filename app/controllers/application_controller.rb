class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception
  	before_action :require_login


	private

	def require_login
	    unless signed_in?
	      flash[:error] = "You must be logged in to access this section"
	      redirect_to sign_in_path # halts request cycle
	    end
	end
  
end
