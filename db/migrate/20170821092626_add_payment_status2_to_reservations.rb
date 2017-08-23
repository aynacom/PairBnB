class AddPaymentStatus2ToReservations < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :payment_status, :boolean
  end
end
