class AddPaymentStatusToReservations < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :payment, :integer
  end
end
