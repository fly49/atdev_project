class ChangeConvertColumnsToFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :converts, :currency_give, :float
    change_column :converts, :currency_take, :float
    change_column :converts, :exchange_rates, :float
  end
end
