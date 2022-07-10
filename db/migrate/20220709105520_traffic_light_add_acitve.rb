class TrafficLightAddAcitve < ActiveRecord::Migration[7.0]
  def change
    add_column :traffic_lights,
               :active,
               :boolean,
               default: true,
               comment: 'true - включен, false - выключен'
  end
end
