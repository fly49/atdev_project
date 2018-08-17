class CreateConverts < ActiveRecord::Migration[5.2]
  def change
    create_table :converts do |t|
      t.string :currency_from
      t.string :currency_to
      t.integer :currency_give
      t.integer :currency_take
      t.integer :exchange_rates

      t.timestamps
    end
  end
end
