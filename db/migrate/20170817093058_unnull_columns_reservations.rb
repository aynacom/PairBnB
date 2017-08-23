class UnnullColumnsReservations < ActiveRecord::Migration[5.1]
  def change
  	change_column_null :reservations, :check_in_date, false
  	change_column_null :reservations, :check_out, false
  end
end
