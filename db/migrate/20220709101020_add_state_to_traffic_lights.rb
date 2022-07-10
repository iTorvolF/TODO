class AddStateToTrafficLights < ActiveRecord::Migration[7.0]
  def change
    add_column :traffic_lights, :state, :string
  end
end
