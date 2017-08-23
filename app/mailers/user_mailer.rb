class UserMailer < ApplicationMailer
	default from: 'aynacom.webdev@gmail.com'
 
	def welcome_email(user)
	    @user = user
	    @url  = 'http://localhost:3000/sign_in'
	    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  	end
end
