class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  validates :check_in_date, presence: true
  validates :check_out, presence: true
  # validates :check_out, numericality: { greater_than: :check_in_date}

  validate :valid_checkout




  def valid_checkout
    	if !self.check_in_date.nil?&&!self.check_out.nil?
      # byebug
    	   errors.add(:check_out, " date is earlier than the check in date") if check_in_date >= check_out
      end

  end

end
