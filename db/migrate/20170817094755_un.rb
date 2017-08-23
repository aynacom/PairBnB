class Un < ActiveRecord::Migration[5.1]
  def change
  	  	change_column_null :reservations, :check_in_date, true
  	change_column_null :reservations, :check_out, true
  end
end
