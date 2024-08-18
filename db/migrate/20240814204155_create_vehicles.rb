# frozen_string_literal: true

class CreateVehicles < ActiveRecord::Migration[7.1]
  def change
    create_table :vehicles do |t|
      t.references :customer, foreign_key: true, index: true
      t.integer :vehicle_type
      t.string :name
      t.integer :length

      t.timestamps
    end
  end
end
