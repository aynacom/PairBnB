class User < ApplicationRecord
  include Clearance::User

  mount_uploader :photo, PhotoUploader
  # attr_accessible :remote_photo_url
  # superadmin, moderator and customer
enum status: [ :superadmin, :moderator, :customer]
has_many :authentications, dependent: :destroy
has_many :listings, dependent: :destroy
has_many :reservations, dependent: :destroy

    def self.create_with_auth_and_hash(authentication, auth_hash)
      user = self.create!(
        first_name: auth_hash["first_name"],
        email: auth_hash["extra"]["raw_info"]["email"],
        password: SecureRandom.hex(6)
      )
      user.authentications << authentication
      return user
    end

    # grab fb_token to access Facebook for user data
    def fb_token
      x = self.authentications.find_by(provider: 'facebook')
      return x.token unless x.nil?
    end



end
